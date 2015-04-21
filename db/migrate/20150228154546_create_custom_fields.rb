class CreateCustomFields < ActiveRecord::Migration
  def change
    create_table :custom_fields do |t|
      t.string :field_name
      t.string :field_type
      t.boolean :required
      t.string :customizable_model_name
      t.text :allowed_values

      t.timestamps null: false
    end
  end
end
