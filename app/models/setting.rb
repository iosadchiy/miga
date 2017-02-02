# == Schema Information
#
# Table name: settings
#
#  id                :integer          not null, primary key
#  price_electricity :decimal(, )      not null
#  price_water       :decimal(, )      not null
#

class Setting < ApplicationRecord
  # only one Setting allowed
  validates_each :id do |record, attr, value|
    if record.new_record? && count >= 1
      record.errors.add(attr, I18n.t('settings.only_one_allowed'))
    end
  end
  validates :price_electricity, :price_water, numericality: true

  def self.config
    HashWithIndifferentAccess.new(first.attributes).except(:id)
  end
end
