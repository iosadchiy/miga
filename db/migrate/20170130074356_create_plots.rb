class CreatePlots < ActiveRecord::Migration[5.0]
  def change
    create_table :plots do |t|
      t.string :number, index: true
      t.integer :space
      t.string :cadastre
      t.string :ukrgosact
      t.references :member, foreign_key: true

      t.timestamps
    end
  end
end
