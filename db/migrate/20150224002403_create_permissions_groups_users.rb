class CreatePermissionsGroupsUsers < ActiveRecord::Migration
  def change
    create_table :permissions_groups_users, id: false do |t|
      t.references :user
      t.references :permissions_group
    end

    add_index :permissions_groups_users, [:permissions_group_id, :user_id], name: 'group_user_index'
    add_index :permissions_groups_users, :user_id
  end
end
