class AddRegionToTickets < ActiveRecord::Migration[5.2]
  def change
    add_reference :tickets, :region, foreign_key: true
  end
end
