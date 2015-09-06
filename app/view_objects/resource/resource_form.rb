module Resource
  class ResourceForm < Form
    def initialize(resource, cell_count, args)
      @resource = resource
      @resource_class = resource.class
      @cell_count = cell_count

      @exclude_form_attributes = args[:exclude_form_attributes]
      @form_attributes = find_form_attributes(args[:form_attributes])
      @form_attributes_config = args[:form_attributes_config]

      @exclude_associations = args[:exclude_associations]
      @form_url = args[:form_url]
      @form_config = args[:form_config]
    end

    def attributes
      @attributes ||= initialize_attributes(@resource_class, @form_attributes, @exclude_associations)
    end

    def title
      @title ||= t(model_name(resource.class))
    end

    private

    def initialize_attributes(model_class, form_attributes, exclude_associations)
      attributes = []
      attributes.concat(initialize_form_attributes(form_attributes))
      attributes.concat(initialize_form_association_attributes(model_class, exclude_associations))
      attributes.concat(initialize_form_custom_attributes(model_class))
      attributes.concat(initialize_form_nested_attributes(model_class, exclude_associations))
    end

    def initialize_form_attributes(form_attributes)
      attributes = []

      form_attributes.each do |attribute|
        attributes << {
          name: attribute,
          config: (@form_attributes_config[attribute.to_sym] || {}).merge(wrapper_html: {class: "cell-#{cell_count}"})
        }
      end

      attributes
    end

    def initialize_form_association_attributes(model_class, exclude_associations)
      attributes = []

      [:belongs_to].each do |association|
        associations_names(model_class, association).each do |nested_model|
          next if exclude_associations.find { |e| e ? /#{e.downcase}/ =~ nested_model : false }

          attributes << {
            association_name: nested_model,
            config: (@form_attributes_config[nested_model.to_sym] || {}).merge(wrapper_html: {class: "cell-#{cell_count}"})
          }
        end
      end

      attributes
    end

    def initialize_form_custom_attributes(model_class)
      return [] unless model_class.respond_to? :available_custom_fields

      form_attributes = []

      model_class.available_custom_fields.each do |cf|
        next if cf.field_type == 'formula'
        form_attributes << { name: cf.field_name, config: custom_attribute_config(cf) }
      end

      form_attributes
    end

    def initialize_form_nested_attributes(model_class, exclude_associations)
      attributes = []

      has_many_associations = associations_names(model_class, :has_many)

      model_class.nested_attributes_options.keys.each do |nested_model|
        many = has_many_associations.include? nested_model ? true : false
        attributes << initialize_form_nested_attribute(model_class, nested_model, exclude_associations, many)
      end

      attributes
    end

    def initialize_form_nested_attribute(model_class, nested_model, exclude_associations, many)
      class_association = find_class_association(model_class, nested_model)
      form_attributes = find_form_attributes(class_association.attribute_names)
      {
        title: t(nested_model),
        nested_name: nested_model,
        attributes: initialize_attributes(class_association,
                                          form_attributes,
                                          (exclude_associations << nested_model.to_s.singularize)),
        many: many
      }
    end

    def custom_attribute_config(cf)
      field_type = cf.field_type
      allowed_values = cf.allowed_values

      if CustomField::ASSOCIABLE_MODEL_NAMES.include? field_type.to_sym
        { as: :select, collection: cf.field_class.all }
      elsif allowed_values.blank?
        { as: field_type }
      else
        { as: field_type, collection: allowed_values }
      end
    end

    def model_name(model_class)
      model_class.name.split('::')[-1].gsub(/(.)([A-Z])/, '\1_\2').downcase.to_sym
    end

    def associations_names(model_class, association)
      model_class.reflect_on_all_associations(association).reject { |value| value.options.key?(:through) }.map(&:name)
    end

    def find_class_association(model_class, nested_model_name)
      model_class.reflect_on_all_associations.find { |association| association.name == nested_model_name }.klass
    end

    def find_form_attributes(attributes)
      attributes.reject { |value| @exclude_form_attributes.find { |e| /#{e}/ =~ value } }
    end
  end
end
