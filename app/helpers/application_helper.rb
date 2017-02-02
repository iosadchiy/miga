module ApplicationHelper
  # @param model class - The model class (e.g. User)
  # @param enum symbol - The enum defined on `model` (e.g. :status)
  # Returns: [["Активен", :active], ["Исключен", :deleted]]
  def options_for_enum(model, enum)
    model.send(enum.to_s.pluralize).keys.map { |key|
      [model.human_attribute_name("#{enum}.#{key}"), key]
    }
  end
end
