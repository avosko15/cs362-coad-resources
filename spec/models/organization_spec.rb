require 'rails_helper'

RSpec.describe Organization, type: :model do

  # it "exists" do
  #   Organization.new
  # end

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:status) }
  it { is_expected.to respond_to(:phone) }
  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:rejection_reason) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:liability_insurance) }
  it { is_expected.to respond_to(:primary_name) }
  # t.string "secondary_name"
  # t.string "secondary_phone"
  # t.string "title"
  # t.integer "transportation"
end
