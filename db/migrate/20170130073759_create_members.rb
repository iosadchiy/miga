class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.string :fio, null: false
      t.string :address
      t.string :phone
      t.string :email
      t.integer :status, index: true, null: false

      t.timestamps
    end
  end
end
