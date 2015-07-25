class Form < ViewObject
  attr_accessor :resource, :title, :attributes, :in_group_of, :form_url, :form_config

  def initialize(resource, title, attributes, form_url, form_config, in_group_of = 1)
    @resource = resource
    @title = title
    @attributes = attributes
    @in_group_of = in_group_of
    @form_url = form_url
    @form_config = form_config
  end
end
