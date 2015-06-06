class Form < ViewObject
  attr_accessor :resource, :title, :attributes, :in_group_of

  def initialize(resource, title, attributes, in_group_of = 1)
    @resource = resource
    @title = title
    @attributes = attributes
    @in_group_of = in_group_of
  end
end
