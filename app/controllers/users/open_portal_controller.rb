class Users::OpenPortalController < OpenPortalController

  protected

  def namespace_url
    [:users]
  end

  def relation_name
    self.class.name.split('::')[-1].sub(/Controller$/, '').underscore
  end

  def find_all_resources
    @q = current_user.send(relation_name).ransack(params[:q])
    @resources = pagination? ? @q.result.page(params[:page]) : @q.result
  end

  def find_resource
    @resource = current_user.send(relation_name).find(params[:id])
  rescue
    render_404
  end

  def build_resource
    @resource = current_user.send(relation_name).build
  end

  def build_resource_from_params
    @resource = current_user.send(relation_name).build(safe_params)
  end
end
