class AddResourceCategoryToTickets < ActiveRecord::Migration[5.2]
  def change
    add_reference :tickets, :resource_category, foreign_key: true
  end
end
