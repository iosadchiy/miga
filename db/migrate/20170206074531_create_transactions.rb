class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.string :type, null: false, index: true
      t.decimal :total, null: false
      t.integer :start_display
      t.integer :end_display
      t.integer :difference
      t.text :details, null: false
      t.references :payment, foreign_key: true
      t.references :register, foreign_key: true

      t.timestamps
    end
  end
end
