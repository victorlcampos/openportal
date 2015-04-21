class CustomFieldValue < ActiveRecord::Base
  belongs_to :custom_field
  belongs_to :customizable, polymorphic: true

  delegate :field_name, :allowed_values, :required?, :field_type, :formula, to: :custom_field

  after_initialize :create_association_methods

  def value
    my_value = read_attribute(:value)
    send("value_#{field_type}".to_sym, my_value)
  rescue NoMethodError
    my_value
  end

  def value_date(my_value)
    eval(my_value).map{ |_,v| v}.join('-').to_date
  end

  def value_formula(_)
    eval(formula)
  end

  def value_float(my_value)
    my_value.to_f
  end

  def value_integer(my_value)
    my_value.to_i
  end

  def create_association_methods
    CustomField::ASSOCIABLE_MODEL_NAMES.each do |associable_model_name|
      method_name = "value_#{associable_model_name}"

      next if respond_to?(method_name)

      self.class.send(:define_method, method_name) do |value|
        associable_model_name.camelize.constantize.find(value)
      end
    end
  end
end