class ApplicationController < ActionController::Base
  include Devise::Controllers::Helpers
  helper_method :current_user, :user_signed_in?, :is_admin, :is_book_locked, :lookup_book, :cart_size
  before_action :configure_devise_parameters, if: :devise_controller?
  before_action :update_book_locks
  mattr_reader :book_locks
  @@book_locks = {} # initialize to empty hash because no books are locked at this point

  def configure_devise_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :name, :address, :phone_number, :credit_card_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :name, :address, :phone_number, :credit_card_number])
  end

  def is_admin
    return current_user.email == admin_email
  end

  def admin_email
    "admin@ncsu.edu"
  end

  def lock_book(book)
    puts "#{current_user.username} locking book #{book.id}"
    self.book_locks[book.id] = current_user.username
  end

  def update_book_locks
    puts "updating book locks"
    self.book_locks.each do |key, value|
      if current_user && value == current_user.username
        puts "#{current_user.username} giving up lock for book #{key}"
        self.book_locks[key] = nil # the current user has navigated so we remove their lock on the book
      end
    end
  end

  def is_book_locked(book)
    puts "checking if book is locked"
    return self.book_locks[book.id] != nil
  end

  def current_users_cart_id
    if current_user
      return "#{current_user.username}_cart"
    end
  end

  def lookup_book(book_id)
    book = Book.find(book_id)
  end

  def cart_size
    size = 0
    if session[current_users_cart_id] != nil
      size = session[current_users_cart_id].values().length
    end
    return size
  end
end