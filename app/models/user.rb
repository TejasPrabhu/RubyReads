class User < ApplicationRecord
  has_many :books
  has_many :reviews, dependent: :destroy
  has_many :transactions , dependent: :destroy

  validates :username, :name, :email, presence: true
  validates :credit_card_number, allow_blank: true, length: {is: 16}
  validates :phone_number, allow_blank: true, length: {minimum: 10, maximum: 15 }

  before_destroy :delete_reviews #, :delete_transactions
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  private

  def delete_reviews
    reviews.destroy_all
  end


  def delete_transactions
    transactions.destroy_all
  end


end
