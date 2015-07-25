class AddFormulaToCustomField < ActiveRecord::Migration
  def change
    add_column :custom_fields, :formula, :text
  end
end
