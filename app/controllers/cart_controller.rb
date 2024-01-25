class CartController < ApplicationController
  helper_method :add_to_cart
  before_action :authenticate_user!

  def index
    if session[current_users_cart_id]
      @cart_items = session[current_users_cart_id].values().map{ |txn| Transaction.new(txn) }
    else
      @cart_items = []
    end
  end

  def add_to_cart
    if session[current_users_cart_id] == nil
      session[current_users_cart_id] = {}
    end
    book = Book.find(params[:book_id])

    has_txn_key = session[current_users_cart_id].key?(book.id.to_s)
    if has_txn_key
      puts "updating txn #{book.id}"
      txn_params = session[current_users_cart_id][book.id.to_s]
      transaction = Transaction.new(txn_params)
      transaction.quantity += 1
    else
      transaction = Transaction.new
      if book
        transaction.book_id = book.id
        transaction.quantity = 1
      end
    end
    session[current_users_cart_id][book.id] = transaction

    respond_to do |format|
      format.html { redirect_to books_url }
    end
  end

  def remove_from_cart
    book_id = params[:id]
    session[current_users_cart_id].delete(book_id)
    respond_to do |format|
      format.html { redirect_to cart_url }
    end
  end

  def clear_cart
    session[current_users_cart_id] = {}
    respond_to do |format|
      format.html { redirect_to cart_url }
    end
  end

  def purchase_cart
    txn = params[:txn]
    books = txn[:book_id]
    quantities = txn[:quantity]

    books.each_with_index do |book_id, index|
      book = Book.find(book_id)
      transaction = Transaction.new
      transaction.transaction_number = rand(100000000000000000)
      transaction.user_id = current_user.id
      transaction.credit_card_number = txn[:credit_card_number]
      transaction.phone_number = txn[:phone_number]
      transaction.address = txn[:address]
      transaction.book_id = book.id
      transaction.quantity = quantities[index].to_i
      transaction.total_price = transaction.quantity * book.price

      if transaction.valid? && transaction.save
        book.stock = book.stock - transaction.quantity
        book.save()
        session[current_users_cart_id].delete(book_id)
      end
    end

    respond_to do |format|
      format.html { redirect_to transactions_url }
    end
  end
end
