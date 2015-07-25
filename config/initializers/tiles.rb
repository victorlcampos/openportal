OPEN_PORTAL_TILES = {}

tiles_path = File.join(Rails.root, 'config', 'tiles.yml')
begin
  tiles = YAML.load(File.read(tiles_path))
  OPEN_PORTAL_TILES.deep_merge!(tiles)
rescue
end

Bundler.load.specs.each do |spec|
  tiles_path = File.join(spec.full_gem_path, 'config', 'tiles.yml')
  begin
    tiles = YAML.load(File.read(tiles_path))
    OPEN_PORTAL_TILES.deep_merge!(tiles)
  rescue
  end
end
