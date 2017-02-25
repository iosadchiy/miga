class AddCustomDueIdToSettings < ActiveRecord::Migration[5.0]
  def change
    add_column :settings, :custom_due_id, :integer
  end
end
