class CreateDues < ActiveRecord::Migration[5.0]
  def change
    create_table :dues do |t|
      t.integer :kind,    null: false
      t.string  :purpose, null: false
      t.integer :unit,    null: false
      t.decimal :price,   null: false

      t.timestamps
    end
  end
end
