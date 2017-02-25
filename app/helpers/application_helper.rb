module ApplicationHelper
  # @param model class - The model class (e.g. User)
  # @param enum symbol - The enum defined on `model` (e.g. :status)
  # Returns: [["Активен", :active], ["Исключен", :deleted]]
  def options_for_enum(model, enum)
    model.send(enum.to_s.pluralize).keys.map { |key|
      [model.human_attribute_name("#{enum}.#{key}"), key]
    }
  end

  # Adds a new nested fields form
  def link_to_add_fields(name=nil, ff=nil, association=nil, options=nil,
    html_options=nil, attributes={}, &block)
    # If a block is provided there is no name attribute and the arguments are
    # shifted with one position to the left. This re-assigns those values.
    f, association, options, html_options = name, ff, association, options if block_given?

    options ||= {}
    html_options ||= {}

    locals = options[:locals] || {}
    partial = options[:partial] || association.to_s.singularize + '_fields'

    # Render the form fields from a file with the association name provided
    new_object = ff.object.class.reflect_on_association(association).klass.new(attributes)
    fields = ff.fields_for(association, new_object, child_index: 'new_record') do |builder|
      render(partial, locals.merge!( ff: builder))
    end

    # The rendered fields are sent with the link within the data-form-prepend attr
    html_options['data-form-prepend'] = raw CGI::escapeHTML( fields )
    html_options['href'] = '#'

    content_tag(:a, name, html_options, &block)
  end

  def app_version
    @_version ||= "Revision: " + File.mtime('REVISION').to_s(:short) rescue nil
  end
end
