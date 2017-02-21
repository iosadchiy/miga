class AddCashierToSettings < ActiveRecord::Migration[5.0]
  def change
    add_column :settings, :cashier, :string
  end
end
