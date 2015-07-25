class CustomField < ActiveRecord::Base
  serialize :allowed_values, Array
  has_many :custom_fields_values, class_name:  'CustomFieldValue', dependent: :destroy

  CUSTOMIZABLE_MODEL_NAMES = []
  ASSOCIABLE_MODEL_NAMES = []

  def self.field_types
    [
      :boolean,
      :string,
      :email,
      :url,
      :tel,
      :password,
      :search,
      :uuid,
      :text,
      :file,
      :hidden,
      :integer,
      :float,
      :decimal,
      :range,
      :datetime,
      :date,
      :time,
      :select,
      :radio_buttons,
      :check_boxes,
      :country,
      :time_zone,
      :formula
    ].concat(ASSOCIABLE_MODEL_NAMES)
  end

  def self.customizable_model_names(user)
    CUSTOMIZABLE_MODEL_NAMES
  end

  def self.associable_model_names(user)
    ASSOCIABLE_MODEL_NAMES
  end

  def field_class
    field_type.camelize.constantize
  end
end
