class AddNotesToMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :members, :notes, :text, null: false, default: ''
  end
end
