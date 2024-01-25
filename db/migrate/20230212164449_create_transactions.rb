class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :transaction_number
      t.integer :credit_card_number
      t.string :address
      t.string :phone_number
      t.integer :quantity
      t.decimal :total_price

      t.timestamps
    end
    add_index :transactions, :transaction_number, unique: true
  end
end
