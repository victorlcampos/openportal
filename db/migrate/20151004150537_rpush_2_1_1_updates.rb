class Rpush211Updates < ActiveRecord::Migration
  def change
    add_column :rpush_notifications, :content_available, :boolean
  end
end
