OPEN_PORTAL_MENUS = ActiveSupport::HashWithIndifferentAccess.new

menus_path = File.join(Rails.root, 'config', 'menus.yml')
begin
  menus = YAML.load(File.read(menus_path)).with_indifferent_access
  menus.each do |menu_name, values|
    OPEN_PORTAL_MENUS[menu_name] = {} unless OPEN_PORTAL_MENUS[menu_name]
    OPEN_PORTAL_MENUS[menu_name].merge!(values)
  end
rescue
end

Bundler.load.specs.each do |spec|
  menus_path = File.join(spec.full_gem_path, 'config', 'menus.yml')
  begin
    menus = YAML.load(File.read(menus_path)).with_indifferent_access
    menus.each do |menu_name, values|
      OPEN_PORTAL_MENUS[menu_name] = {} unless OPEN_PORTAL_MENUS[menu_name]
      OPEN_PORTAL_MENUS[menu_name].merge!(values)
    end
  rescue
  end
end

OPEN_PORTAL_PERMISSIONS_BY_CONTROLLER = ActiveSupport::HashWithIndifferentAccess.new

OPEN_PORTAL_MENUS.values.each do |categories|
  categories.values.each do |menu|
    if menu['submenus']
      menu['submenus'].values.each do |submenu|
        if submenu['permission']
          OPEN_PORTAL_PERMISSIONS_BY_CONTROLLER["#{submenu[:url]['controller']}##{submenu[:url]['action']}"] = submenu['permission']
        end
      end
    else
      if menu['permission']
        OPEN_PORTAL_PERMISSIONS_BY_CONTROLLER["#{menu[:url]['controller']}##{menu[:url]['action']}"] = menu['permission']
      end
    end
  end
end
