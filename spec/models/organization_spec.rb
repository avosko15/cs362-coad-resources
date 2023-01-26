require 'rails_helper'

RSpec.describe Organization, type: :model do

  # it "exists" do
  #   Organization.new
  # end

  # attributes from att_accessor
  it { is_expected.to respond_to(:agreement_one) }
  it { is_expected.to respond_to(:agreement_two) }
  it { is_expected.to respond_to(:agreement_three) }
  it { is_expected.to respond_to(:agreement_four) }
  it { is_expected.to respond_to(:agreement_five) }
  it { is_expected.to respond_to(:agreement_six) }
  it { is_expected.to respond_to(:agreement_seven) }
  it { is_expected.to respond_to(:agreement_eight) }

  # attributes used in database
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:status) }
  it { is_expected.to respond_to(:phone) }
  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:rejection_reason) }
  it { is_expected.to respond_to(:liability_insurance) }
  it { is_expected.to respond_to(:primary_name) }
  it { is_expected.to respond_to(:secondary_name) }
  it { is_expected.to respond_to(:secondary_phone) }
  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:transportation) }

  # associations
  it { is_expected.to have_many(:users) }
  it { is_expected.to have_many(:tickets) }
  it { is_expected.to have_and_belong_to_many(:resource_categories) }

end