class CreateCustomFieldValues < ActiveRecord::Migration
  def change
    create_table :custom_field_values do |t|
      t.references :custom_field, foreign_key: true
      t.references :customizable, polymorphic: true
      t.string :value

      t.timestamps null: false
    end

    add_index :custom_field_values, [:custom_field_id, :customizable_id, :customizable_type], name: :custom_field_values_index
  end
end
