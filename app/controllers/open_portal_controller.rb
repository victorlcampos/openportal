class OpenPortalController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  layout 'openportal'
  include CanHelper

  # protect_from_forgery with: :exception
  before_action :verify_permission

  before_action -> { can_view? }, only: [:index, :show]
  before_action -> { can_create? }, only: [:new,   :create]
  before_action -> { can_edit? }, only: [:edit,  :update]
  before_action -> { can_delete? }, only: [:destry]

  before_action :before_index, only: [:index]
  before_action :before_show, only: [:show]
  before_action :before_new, only: [:new]
  before_action :before_create, only: [:create]
  before_action :before_edit, only: [:edit]
  before_action :before_update, only: [:update]
  before_action :before_destroy, only: [:destroy]

  before_action :find_all_resources, only: [:index]
  before_action :find_resource, only: [:show, :edit, :update, :destroy]
  before_action :build_resource, only: [:new]
  before_action :build_resource_from_params, only: [:create]

  helper_method :snake_case_model_name, :index_attributes, :exclude_index_attributes,
                :index_filter_attributes, :exclude_index_filter_attributes,
                :show_attributes, :exclude_show_attributes,
                :form_attributes, :form_attributes_config, :form_config,
                :exclude_form_attributes,
                :exclude_associations, :namespace_url,
                :namespaces, :model_class

  def index; end

  def show; end

  def new; end

  def create
    if @resource.save
      redirect_to (namespace_url << @resource)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @resource.update_attributes(safe_params)
      redirect_to (namespace_url << @resource)
    else
      render :edit
    end
  end

  def destroy
    @resource.destroy
    redirect_to action: :index
  end

  protected

  def before_index; end

  def before_show; end

  def before_new; end

  def before_create; end

  def before_edit; end

  def before_update; end

  def before_destroy; end

  def verify_permission(permission = nil)
    permission ||= OPEN_PORTAL_PERMISSIONS_BY_CONTROLLER["#{controller_name}##{action_name}"]
    (render_401 && return) if permission && (!current_user || !current_user.can?(permission))
  end

  def safe_params
    params.require(namespaces.concat([snake_case_model_name]).join('_')).permit!
  end

  def model_name
    self.class.name.sub(/Controller$/, '').singularize
  end

  def snake_case_model_name
    model_name.split('::')[-1].gsub(/(.)([A-Z])/, '\1_\2').downcase.to_sym
  end

  def namespaces
    params[:controller].split('/')[0..-2]
  end

  def model_class
    model_name.constantize
  end

  def find_all_resources
    @q = model_class.ransack(params[:q])
    @resources = pagination? ? @q.result.page(params[:page]) : @q.result
  end

  def pagination?
    !params[:format] || params[:format] == 'html'
  end

  # TODO: Faze ser configuravel pelo usuario
  def index_attributes
    @index_attributes ||= model_class.attribute_names
  end

  # TODO: Faze ser configuravel pelo usuario
  def exclude_index_attributes
    %w(_id created_at updated_at)
  end

  # TODO: Faze ser configuravel pelo usuario
  def index_filter_attributes
    index_attributes
  end

  # TODO: Faze ser configuravel pelo usuario
  def exclude_index_filter_attributes
    exclude_index_attributes
  end

  def show_attributes
    @show_attributes ||= model_class.attribute_names
  end

  # TODO: Faze ser configuravel pelo usuario
  def exclude_show_attributes
    []
  end

  # TODO: Faze ser configuravel pelo usuario
  def form_attributes
    @form_attributes ||= model_class.attribute_names
  end

  # TODO: Faze ser configuravel pelo usuario
  def form_attributes_config
    {}
  end

  def form_config
    {}
  end

  # TODO: Faze ser configuravel pelo usuario
  def exclude_form_attributes
    %w(id created_at updated_at)
  end

  def namespace_url
    []
  end

  def exclude_associations
    model_class.ancestors.map(&:name)
  end

  def find_resource
    @resource = model_class.find(params[:id])
  rescue
    render_404
  end

  def build_resource
    @resource = model_class.new
  end

  def build_resource_from_params
    @resource = model_class.new(safe_params)
  end

  def render_404
    render_status("#{Rails.root}/public/404", :not_found)
  end

  def render_401
    render_status("#{Rails.root}/public/401", 403)
  end

  def render_status(file, status)
    respond_to do |format|
      format.html { render file: file, layout: false, status: status }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end
end
