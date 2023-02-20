class AddOrganizationsForeignKeyToUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.references :organization, foreign_key: true
    end
  end
end
