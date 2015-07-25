class Chart < ViewObject
  attr_accessor :type, :labels, :series, :options

  def initialize(type, labels, series, options)
    @type = type
    @labels = labels
    @series = series
    @options = options
  end
end
