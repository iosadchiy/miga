class CreateDuesMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :dues_members, id: false do |t|
      t.belongs_to :due, index: true
      t.belongs_to :member, index: true
    end
  end
end
