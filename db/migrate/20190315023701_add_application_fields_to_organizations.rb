class AddApplicationFieldsToOrganizations < ActiveRecord::Migration[5.2]
  def change
    add_column :organizations, :liability_insurance, :boolean, default: false
    add_column :organizations, :primary_name, :string
    add_column :organizations, :secondary_name, :string
    add_column :organizations, :secondary_phone, :string
    add_column :organizations, :title, :string
    add_column :organizations, :transportation, :integer
  end
end
