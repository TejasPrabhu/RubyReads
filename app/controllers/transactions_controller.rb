class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]
  # GET /transactions or /transactions.json
  def index
    if current_user.id != nil
      @transactions = Transaction.where(user_id: current_user.id)
    else
      @transactions = Transaction.all
    end
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    @transaction.transaction_number = rand(100000000000000000)
    @transaction.user_id = current_user.id
    @transaction.credit_card_number = current_user.credit_card_number
    @transaction.phone_number = current_user.phone_number
    @transaction.address = current_user.address

    if @book.nil?
      @book = Book.find(params[:book_id])
      @transaction.book_id = @book.id
    end

    lock_book(@book)
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    @book = Book.find(transaction_params[:book_id])

    if @transaction.valid? && @transaction.save
      @book.stock = @book.stock - @transaction.quantity
      @book.save()
      flash[:notice] = 'Transaction was successfully created.'
    else
      render :new, status: :unprocessable_entity
      return
    end

    respond_to do |format|
      format.html { redirect_to transaction_url(@transaction) }
      format.json { render :show, status: :created, location: @transaction }
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_url, notice: "Transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:transaction_number, :book_id, :user_id, :credit_card_number, :address, :phone_number, :quantity, :total_price)
    end
end
