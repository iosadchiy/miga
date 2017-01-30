class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.string :fio
      t.string :address
      t.string :phone
      t.string :status, index: true

      t.timestamps
    end
  end
end