class AddClosedToTickets < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :closed, :boolean, default: false
    add_column :tickets, :closed_at, :datetime
  end
end
