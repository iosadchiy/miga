class CreateDues < ActiveRecord::Migration[5.0]
  def change
    create_table :dues do |t|
      t.string :name
      t.string :unit
      t.float :price

      t.timestamps
    end
  end
end
