class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.integer :kind, null: false
      t.decimal :total, null: false
      t.decimal :price
      t.integer :start_display
      t.integer :end_display
      t.integer :difference
      t.text :details, null: false
      t.references :payment, foreign_key: true
      t.integer :payable_id, null: false
      t.string :payable_type, null: false

      t.index [:payable_type, :payable_id]

      t.timestamps
    end
  end
end
