class CreateOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations do |t|
      t.string        :name
      t.integer       :status
      t.string        :phone
      t.string        :email
      t.string        :description
      t.string        :rejection_reason
      t.timestamps    null: false
      t.index         ['name'], name: 'index_organizations_on_name', unique: true
      t.index         ['email'], name: 'index_organizations_on_email', unique: true
    end
  end
end
