# == Schema Information
#
# Table name: settings
#
#  id                      :integer          not null, primary key
#  price_electricity       :decimal(, )      not null
#  price_water             :decimal(, )      not null
#  cashier                 :string
#  custom_due_id           :integer
#  price_electricity_day   :decimal(, )      default(0.0), not null
#  price_electricity_night :decimal(, )      default(0.0), not null
#

class Setting < ApplicationRecord
  # only one Setting allowed
  validates_each :id do |record, attr, value|
    if record.new_record? && count >= 1
      record.errors.add(attr, I18n.t('settings.only_one_allowed'))
    end
  end
  validates :price_electricity, :price_electricity_day, :price_electricity_night, :price_water, numericality: true

  def self.instance
    @instance ||= first || Setting.create!
  end

  def self.config
    HashWithIndifferentAccess.new(instance.attributes).except(:id)
  end

  def self.set!(key, value)
    instance.update!(key => value)
  end
end
