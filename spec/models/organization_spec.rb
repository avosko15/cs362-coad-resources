require 'rails_helper'

RSpec.describe Organization, type: :model do

  # it "exists" do
  #   Organization.new
  # end

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:status) }
  # t.integer "status"
  # t.string "phone"
  # t.string "email"
  # t.string "description"
  # t.string "rejection_reason"
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false
  # t.boolean "liability_insurance", default: false
  # t.string "primary_name"
  # t.string "secondary_name"
  # t.string "secondary_phone"
  # t.string "title"
  # t.integer "transportation"
end
