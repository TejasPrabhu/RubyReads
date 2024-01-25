class EnhanceUser < ActiveRecord::Migration[7.0]
  def change
    rename_column(:users, :email, :username)
    add_column(:users, :name, :string, default: '', null: false)
    add_column(:users, :email, :string, default: '', null: false)
    add_column(:users, :address, :string, null: true)
    add_column(:users, :credit_card_number, :integer, null: true)
    add_column(:users, :phone_number, :string, null: true)
  end
end
