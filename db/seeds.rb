# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  admin = User.create(email: 'admin@admin.com', password: 'admin123', password_confirmation: 'admin123')
  admin_group = PermissionsGroup.new(name: :admin)
  admin_group.users << admin
  OPEN_PORTAL_PERMISSIONS.each do |key, permissions|
    admin_group.permissions.concat(permissions)
  end
  admin_group.save!
