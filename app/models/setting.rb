class Setting < ApplicationRecord
  validates_each :id do |record, attr, value|
    if record.new_record? && count >= 1
      record.errors.add(attr, I18n.t('settings.only_one_allowed'))
    end
  end
  def self.config
    HashWithIndifferentAccess.new(first.attributes).except(:id)
  end
end
