class AddActiveToResourceCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :resource_categories, :active, :boolean, default: true
  end
end
