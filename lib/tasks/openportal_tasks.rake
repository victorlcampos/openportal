# desc "Explaining what the task does"
# task :openportal do
#   # Task goes here
# end
namespace :openportal do
  task seed: :environment do |t|
    admin = User.create(email: 'admin@admin.com', password: 'admin123', password_confirmation: 'admin123')
    admin_group = PermissionsGroup.new(name: :admin)
    admin_group.users << admin
    OPEN_PORTAL_PERMISSIONS.each do |key, permissions|
      admin_group.permissions.concat(permissions)
    end
    admin_group.save!
  end
end
