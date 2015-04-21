class Table < ViewObject
  attr_accessor :filters, :q, :toolbar_links, :column_names, :column_values

  def initialize(q, filters, toolbar_links, column_names, column_values)
    @resources = resources
    @filters = filters
    @q = q
    @toolbar_links = toolbar_links
    @column_names = column_names
    @column_values = column_values
  end
end
