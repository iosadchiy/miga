class AddKpoNumber < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :number, :integer, index: true

    Transaction.all.each{|t| t.update_attribute :number, t.id }
  end
end
