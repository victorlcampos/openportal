module CanHelper
  def can_view?
    can(:list)
  end

  def can_edit?
    can(:edit)
  end

  def can_create?
    can(:create)
  end

  def can_delete?
    can(:delete)
  end

  def permissions
    OPEN_PORTAL_PERMISSIONS[controller_name]
  end

  private

  def can(action)
    !permissions || !permissions.include?("#{action}_#{controller_name}") || current_user.can?("#{action}_#{controller_name}")
  end
end
