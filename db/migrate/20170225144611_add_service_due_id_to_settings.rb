class AddServiceDueIdToSettings < ActiveRecord::Migration[5.0]
  def change
    add_column :settings, :service_due_id, :integer
  end
end
