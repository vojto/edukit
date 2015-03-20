class LabeledFormBuilder < ActionView::Helpers::FormBuilder
  %w[text_field password_field text_area].each do |method_name|
    define_method(method_name) do |field_name, *args|
      options = args.extract_options!
      lbl     = options.delete(:label)
      @template.content_tag(
        :p, 
        label(field_name, lbl) + 
        nice_error(field_name) +
        "<br />" + 
        super(field_name, options.merge({:class => "text #{options[:class]}"})),
        :class => has_error?(field_name) ? "errorful" : nil
      )
    end
  end
  
  def collection_select(field_name, *args)
    options = args.extract_options!
    @template.content_tag(
      :p, 
      label(field_name, options[:label]) + 
      nice_error(field_name) +
      "<br />" + 
      super(field_name, *args),
      :class => has_error?(field_name) ? "errorful" : nil
    )
  end
  
  def select(field_name, *args)
    options = args.extract_options!
    @template.content_tag(
      :p, 
      label(field_name, options[:label]) + 
      nice_error(field_name) +
      "<br />" + 
      super(field_name, *args),
      :class => has_error?(field_name) ? "errorful" : nil
    )
  end
  
  def check_box(field_name, *args)
    options = args.extract_options!
    @template.content_tag(:p, super + label(field_name, options[:label], :class => "checkbox"))
  end
  
  def label(field_name, title = nil, *args)
    options = args.extract_options!
    label = title || I18n.t("activerecord.attributes.#{@object_name.to_s}.#{field_name}", :default => field_name.to_s.humanize)
    super(field_name, label, options)
  end

  def has_error? field_name
    if object
      object.errors.invalid? field_name
    else
      nil
    end
  end
  
  def nice_error field_name
    title = I18n.t("activerecord.attributes.#{@object_name.to_s}.#{field_name}", :default => field_name.to_s.humanize)
    if has_error? field_name
      @template.content_tag(:span, "#{title} #{[object.errors.on(field_name)].flatten.first}")
    else
      ""
    end
  end
end