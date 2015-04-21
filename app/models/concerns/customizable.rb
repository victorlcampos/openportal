module Customizable
  extend ActiveSupport::Concern

  included do
    CustomField::CUSTOMIZABLE_MODEL_NAMES << customizable_model_name
    has_many :custom_fields_values, as: :customizable, class: CustomFieldValue, dependent: :destroy, autosave: true

    after_initialize :create_custom_field_methods

    validate :custom_fields_presence
    validate :custom_fields_inclusion
  end

  class_methods do
    def customizable_model_name
      @customizable_model_name ||= self.to_s.split('::')[-1].gsub(/(.)([A-Z])/,'\1_\2').downcase.pluralize.to_sym
    end

    def available_custom_fields
      CustomField.where(customizable_model_name: customizable_model_name)
    end
  end


  def available_custom_fields
    @available_custom_fields ||= self.class.available_custom_fields
  end

  private

  def fields_values
    return @fields_values if @fields_values
    @fields_values = {}

    available_custom_fields.each do |cf|
      found = false

      self.custom_fields_values.each do |cfv|
        if cf.id == cfv.custom_field_id
          @fields_values[cf.id] = cfv
          found = true
          break
        end
      end

      next if found

      cfv = self.custom_fields_values.build(custom_field_id: cf.id)
      @fields_values[cf.id] = cfv
    end

    @fields_values
  end

  def create_custom_field_methods
    fields_values.each do |cf_id, cfv|
      next if cfv.field_name.blank? || respond_to?(cfv.field_name)

      self.class.send(:define_method, cfv.field_name) do
        fields_values[cf_id].value
      end

      next if cfv.field_type == 'formula'

      self.class.send(:define_method, "#{cfv.field_name}=") do |value|
        fields_values[cf_id].value = value
      end
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
