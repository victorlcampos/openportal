module Resource
  class ResourceTable < Table
    include CanHelper

    attr_accessor :resources, :controller_name, :current_user

    def initialize(resources, q, current_user, args)
      @resources = resources
      @q = q

      @index_attributes                = args[:index_attributes] || []
      @exclude_index_attributes        = args[:exclude_index_attributes] || []
      @index_filter_attributes         = args[:filter_attributes] || []
      @exclude_index_filter_attributes = args[:exclude_index_filter_attributes] || []

      params = args[:params]
      @toolbar_links = initialize_toolbar_links(params)

      @controller_name = params[:controller].split('/')[-1]
      @current_user    = current_user
    end

    def column_names
      return @column_names if @column_names

      @column_names = resource_attributes

      @column_names << '' if can_view?
      @column_names << '' if can_edit?
      @column_names << '' if can_delete?
    end

    def column_values
      @column_values ||= initialize_column_values
    end

    def filters
      @filters ||= initialize_filters
    end

    private

    def initialize_column_values
      columns = {}

      resources.each do |resource|
        columns[resource] = []
        set_attribute_columns(resource, columns[resource])
        set_action_columns(resource, columns[resource])
      end

      columns
    end

    def set_attribute_columns(resource, columns)
      resource_attributes.each do |attribute|
        columns << resource.send(attribute)
      end
    end

    def set_action_columns(resource, columns)
      columns << link_to(t('form.view'), url_for(resource)) if can_view?
      columns << link_to(t('form.edit'), url_for([:edit, resource])) if can_edit?
      columns << link_to(t('form.delete'), url_for(resource), method: 'delete')
    end

    def resource_attributes
      @index_attributes - @exclude_index_attributes
    end

    def initialize_filters
      @index_filter_attributes - @exclude_index_filter_attributes
    end

    def initialize_toolbar_links(params)
      @initialize_toolbar_links = [export_link(params)]
      @initialize_toolbar_links << new_link(params) if can_create?
      @initialize_toolbar_links
    end

    def export_link(params)
      {
        name: I18n.t('table.export'),
        url: url_for(controller: params[:controller], action: params[:action], q: params[:q], format: 'xlsx')
      }
    end

    def new_link(params)
      {
        name: I18n.t('form.new'),
        url: url_for(action: :new, controller: params[:controller])
      }
    end
  end
end
