class AddElectricityTariffsToSettings < ActiveRecord::Migration[5.0]
  def change
    add_column :settings, :price_electricity_day, :decimal, null: false, default: 0
    add_column :settings, :price_electricity_night, :decimal, null: false, default: 0
  end
end
