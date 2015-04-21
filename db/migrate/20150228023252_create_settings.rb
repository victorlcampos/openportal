class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :key
      t.text :preferences

      t.timestamps null: false
    end
  end
end
