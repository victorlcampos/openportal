class CustomFieldsController < OpenPortalController
  before_action -> { verify_permission('admin') }

  protected

  def form_attributes_config
    {
      field_type: {
        collection: CustomField.field_types
      },
      customizable_model_name: {
        collection: CustomField.customizable_model_names(current_user)
      },
      allowed_values: {
        input_html: { value: @resource.allowed_values.join("\n") }
      }
    }
  end

  def before_create
    transform_allowed_values_string_to_array
  end

  def before_update
    transform_allowed_values_string_to_array
  end

  def transform_allowed_values_string_to_array
    params[:custom_field][:allowed_values] = params[:custom_field][:allowed_values].split(/\n/).map(&:strip)
  end

end
