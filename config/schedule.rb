require File.expand_path(File.dirname(__FILE__) + "/environment")

def define_cron_task(path)
  schedules_path = File.join(path, 'config', 'schedule.yml')
  begin
    schedules = YAML.load(File.read(schedules_path)).with_indifferent_access

    schedules.each do |schedule_name, values|
      every values[:cron] do
        rake values[:rake]
      end
    end
  rescue
  end
end

define_cron_task(Rails.root)

Bundler.load.specs.each do |spec|
  define_cron_task(spec.full_gem_path)
end
