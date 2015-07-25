OPEN_PORTAL_PERMISSIONS = {}

permissions_path = File.join(Rails.root, 'config', 'permissions.yml')
begin
  permissions = YAML.load(File.read(permissions_path))
  OPEN_PORTAL_PERMISSIONS.deep_merge!(permissions)
rescue
end

Bundler.load.specs.each do |spec|
  permissions_path = File.join(spec.full_gem_path, 'config', 'permissions.yml')
  begin
    YAML.load(File.read(permissions_path)).each do |key, permissions|
      OPEN_PORTAL_PERMISSIONS[key] ||= []
      OPEN_PORTAL_PERMISSIONS[key] = OPEN_PORTAL_PERMISSIONS[key] | permissions
    end
  rescue
  end
end
