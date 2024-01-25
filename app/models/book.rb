class Book < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :transactions, dependent: :destroy

  validates :name, :author, :publisher, presence: true

  validates :stock, presence: true,
  numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :price, presence: true,
  numericality: { greater_than_or_equal_to: 0 }

  private

  def delete_reviews
    reviews.destroy_all
  end


  def delete_transactions
    transactions.destroy_all
  end

end
