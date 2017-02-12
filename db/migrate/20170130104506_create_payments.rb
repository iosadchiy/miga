class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.references :member, foreign_key: true
      t.integer :status, null: false
      t.decimal :total, null: false

      t.timestamps
    end
  end
end
