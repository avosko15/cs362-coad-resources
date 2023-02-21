class SetDefaultUserRole < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :role, :integer, :default => 1
  end
end
