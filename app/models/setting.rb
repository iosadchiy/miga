# == Schema Information
#
# Table name: settings
#
#  id                :integer          not null, primary key
#  price_electricity :decimal(, )      not null
#  price_water       :decimal(, )      not null
#  cashier           :string
#  service_due_id    :integer
#

class Setting < ApplicationRecord
  # only one Setting allowed
  validates_each :id do |record, attr, value|
    if record.new_record? && count >= 1
      record.errors.add(attr, I18n.t('settings.only_one_allowed'))
    end
  end
  validates :price_electricity, :price_water, numericality: true

  def self.instance
    first || Setting.create!
  end

  def self.config
    HashWithIndifferentAccess.new(first.attributes).except(:id)
  end

  def self.set!(key, value)
    instance.update!(key => value)
  end
end
