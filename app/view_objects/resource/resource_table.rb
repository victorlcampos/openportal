class Resource::ResourceTable < Table
  include CanHelper

  attr_accessor :controller_name, :current_user

  def initialize(resources, q, current_user, args)
    @resources = resources
    @q = q

    @index_attributes                = args[:index_attributes]                || []
    @exclude_index_attributes        = args[:exclude_index_attributes]        || []
    @index_filter_attributes         = args[:filter_attributes]               || []
    @exclude_index_filter_attributes = args[:exclude_index_filter_attributes] || []

    @filters = initialize_filters

    params = args[:params]
    @toolbar_links = initialize_toolbar_links(params)

    @controller_name = params[:controller].split('/')[-1]
    @current_user    = current_user
  end

  def column_names
    return @column_names if @column_names

    @column_names = @index_attributes - @exclude_index_attributes

    @column_names << '' if can_view?
    @column_names << '' if can_edit?
    @column_names << '' if can_delete?
  end

  def column_values
    @column_values if @column_values

    columns = {}

    resources.each do |resource|
      columns[resource] = []

      (@index_attributes - @exclude_index_attributes).each do |attribute|
        columns[resource] << resource.send(attribute)
      end

      columns[resource] << link_to(t('form.view')  , url_for(resource)) if can_view?
      columns[resource] << link_to(t('form.edit')  , url_for([:edit, resource])) if can_edit?
      columns[resource] << link_to(t('form.delete'), url_for(resource), method: 'delete')
    end

    @column_values = columns
  end

  private

  def initialize_filters
    @index_filter_attributes - @exclude_index_filter_attributes
  end

  def initialize_toolbar_links(params)
    @initialize_toolbar_links = [
      {
        name: I18n.t('table.export'),
        url: url_for(controller: params[:controller], action: params[:action], q: params[:q], format: 'xlsx')
      }
    ]

    @initialize_toolbar_links.concat([
      {
        name: I18n.t('form.new'),
        url: url_for(action: :new, controller: params[:controller])
      }
    ]) if can_create?

    @initialize_toolbar_links
  end
end
