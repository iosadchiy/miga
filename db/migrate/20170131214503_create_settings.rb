class CreateSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :settings do |t|
      t.decimal :price_electricity, null: false
      t.decimal :price_water, null: false
    end
  end
end
