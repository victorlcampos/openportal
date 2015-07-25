class CreatePermissionsGroups < ActiveRecord::Migration
  def change
    create_table :permissions_groups do |t|
      t.string :name
      t.text :permissions

      t.timestamps null: false
    end
  end
end
