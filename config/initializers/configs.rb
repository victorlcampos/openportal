OPEN_PORTAL_CONFIGS = ActiveSupport::HashWithIndifferentAccess.new

configs_path = File.join(Rails.root, 'config', 'configs.yml')
begin
  configs = YAML.load(File.read(configs_path)).with_indifferent_access
  configs.each do |config_name, values|
    OPEN_PORTAL_CONFIGS[config_name] = {} unless OPEN_PORTAL_CONFIGS[config_name]
    OPEN_PORTAL_CONFIGS[config_name].merge!(values)
  end
rescue
end

Bundler.load.specs.each do |spec|
  configs_path = File.join(spec.full_gem_path, 'config', 'configs.yml')
  begin
    configs = YAML.load(File.read(configs_path)).with_indifferent_access
    configs.each do |config_name, values|
      OPEN_PORTAL_CONFIGS[config_name] = {} unless OPEN_PORTAL_CONFIGS[config_name]
      OPEN_PORTAL_CONFIGS[config_name].merge!(values)
    end
  rescue
  end
end
