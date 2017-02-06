class CreateRegisters < ActiveRecord::Migration[5.0]
  def change
    create_table :registers do |t|
      t.references :plot, foreign_key: true
      t.integer :kind, null: false
      t.string :name
      t.string :number
      t.integer :initial_display
      t.string :seal

      t.timestamps
    end
  end
end
