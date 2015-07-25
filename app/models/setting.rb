class Setting < ActiveRecord::Base
  serialize :preferences, HashWithIndifferentAccess

  def self.[](key)
    Setting.where(key: key).first_or_initialize
  end
end
