class DeleteTotalFromPayments < ActiveRecord::Migration[5.0]
  def change
    remove_column :payments, :total, :decimal, null: false
  end
end
