require 'rails_helper'

RSpec.describe Ticket, type: :model do

  # it "exists" do
  #   Ticket.new
  # end

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:description) }
  
  # t.string "name"
  # t.string "description"
  # t.string "phone"
  # t.integer "organization_id"
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false
  # t.boolean "closed", default: false
  # t.datetime "closed_at"
  # t.integer "resource_category_id"
  # t.integer "region_id"

end
