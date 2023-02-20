class CreateResources < ActiveRecord::Migration[5.2]
  def change
    create_table :resources do |t|
      t.integer       :quantity, null: true
      t.string        :description, default: "", null: false
      t.references    :organization, foreign_key: true
      t.references    :resource_category, foreign_key: true
      t.timestamps
    end
  end
end
