class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.decimal :total
      t.integer :start_display
      t.integer :end_display
      t.text :details
      t.references :member, foreign_key: true
      t.references :payment, foreign_key: true
      t.references :register, foreign_key: true

      t.timestamps
    end
  end
end
