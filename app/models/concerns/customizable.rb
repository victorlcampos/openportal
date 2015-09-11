module Customizable
  extend ActiveSupport::Concern

  included do
    CustomField::CUSTOMIZABLE_MODEL_NAMES << customizable_model_name
    has_many :custom_fields_values, as: :customizable, class_name: 'CustomFieldValue', dependent: :destroy, autosave: true

    after_initialize :create_custom_field_methods

    validate :custom_fields_presence
    validate :custom_fields_inclusion
  end

  class_methods do
    def customizable_model_name
      @customizable_model_name ||= name.split('::')[-1].gsub(/(.)([A-Z])/, '\1_\2').downcase.pluralize.to_sym
    end

    def available_custom_fields
      CustomField.where(customizable_model_name: customizable_model_name)
    end
  end

  private

  def fields_values
    @fields_values ||= initialize_fields_values
  end

  def initialize_fields_values
    values = {}

    self.class.available_custom_fields.each do |cf|
      next if find_and_initialize_custom_field_value(cf, values)

      cfv = custom_fields_values.build(custom_field_id: cf.id)
      values[cf.id] = cfv
    end

    values
  end

  def find_and_initialize_custom_field_value(cf, values)
    custom_fields_values.each do |cfv|
      next unless cf.id == cfv.custom_field_id

      values[cf.id] = cfv
      return true
    end

    false
  end

  def create_custom_field_methods
    fields_values.each do |cf_id, cfv|
      next if cfv.field_name.blank? || respond_to?(cfv.field_name)

      define_getter(cf_id, cfv)

      next if cfv.field_type == 'formula'

      define_setter(cf_id, cfv)
    end
  end

  def define_getter(cf_id, cfv)
    self.class.send(:define_method, cfv.field_name) do
      fields_values[cf_id].value
    end
  end

  def define_setter(cf_id, cfv)
    self.class.send(:define_method, "#{cfv.field_name}=") do |value|
      fields_values[cf_id].value = value
    end
  end

  def custom_fields_presence
    custom_fields_values.each do |cfv|
      errors.add(cfv.field_name.to_sym, :blank) if cfv.required? && cfv.value.blank?
    end
  end

  def custom_fields_inclusion
    custom_fields_values.each do |cfv|
      next if cfv.value.blank? || cfv.allowed_values.blank?
      errors.add(cfv.field_name.to_sym, :inclusion) unless cfv.allowed_values.include?(cfv.value)
    end
  end
end
