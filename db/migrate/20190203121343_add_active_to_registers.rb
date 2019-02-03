class AddActiveToRegisters < ActiveRecord::Migration[5.0]
  def change
    add_column :registers, :active, :boolean, null: false, default: true
  end
end
