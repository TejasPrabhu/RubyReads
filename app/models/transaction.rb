class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :address, :phone_number, :credit_card_number, presence: true
  validates :phone_number, length: {minimum: 10, maximum: 15 }
  validates :credit_card_number, length: {is: 16}

  validates :quantity, presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :validate_quantity_against_stock

  def validate_quantity_against_stock
    if quantity.present? && book.present? && quantity > book.stock
      errors.add(:quantity, "cannot be greater than stock quantity")
    end
  end
end

