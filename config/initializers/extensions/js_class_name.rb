module JsClassName

  def js_class_name
    "Views.#{parsed_controller_name}.#{parsed_action_name}"
  end

  private

  def parsed_action_name
    case action_name
      when 'create' then 'New'
      when 'update' then 'Edit'
      else action_name
    end.camelize
  end

  def parsed_controller_name
    controller_name = controller.class.name.gsub(/Controller$/, '')
    controller_name.camelize.gsub('::', '.')
  end

  ::ActionView::Base.send :include, self
end
