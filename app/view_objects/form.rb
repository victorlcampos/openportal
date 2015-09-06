class Form < ViewObject
  attr_accessor :resource, :title, :attributes, :cell_count, :form_url, :form_config, :submit_title

  def initialize(resource, title, attributes, form_url, form_config, submit_title, cell_count = 1)
    @resource = resource
    @title = title
    @attributes = attributes
    @cell_count = cell_count
    @form_url = form_url
    @form_config = form_config
    @submit_title = submit_title
  end
end
