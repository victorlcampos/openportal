class Table < ViewObject
  attr_accessor :filters, :q, :toolbar_links, :column_names, :column_values

  def initialize(q, filters, toolbar_links, column_names, column_values)
    @q = q
    @filters = filters
    @toolbar_links = toolbar_links
    @column_names = column_names
    @column_values = column_values
  end
end
