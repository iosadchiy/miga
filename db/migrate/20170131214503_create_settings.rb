class CreateSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :settings do |t|
      t.float :price_electricity
      t.float :price_water
    end
  end
end
