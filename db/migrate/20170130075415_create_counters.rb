class CreateCounters < ActiveRecord::Migration[5.0]
  def change
    create_table :counters do |t|
      t.string :type
      t.string :number
      t.string :seal
      t.integer :display
      t.references :member, foreign_key: true

      t.timestamps
    end
  end
end
