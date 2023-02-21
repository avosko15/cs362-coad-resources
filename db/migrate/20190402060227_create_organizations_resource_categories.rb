class CreateOrganizationsResourceCategories < ActiveRecord::Migration[5.2]
  def change
    create_join_table :organizations, :resource_categories do |t|
      t.index [:organization_id, :resource_category_id], name: 'organization_resource_category'
    end
  end
end
