class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.integer :category_id
      t.decimal :amount

      t.timestamps
    end
    add_foreign_key :transactions, :categories, column: :category_id
    add_index :transactions, :category_id
    add_foreign_key :transactions, :users, column: :user_id
    add_index :transactions, :user_id
  end
end
