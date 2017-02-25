class AddPurposeToTransactions < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :purpose, :string, null: false, default: ''
  end
end
