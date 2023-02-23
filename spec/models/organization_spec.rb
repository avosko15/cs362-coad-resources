require 'rails_helper'


RSpec.describe Organization, type: :model do

  setup do
    @default_org = build(:organization)
    @named_org = build(:organization, :name => "Blue Cross")
  end

  # instantiation - 2.2

  # it "exists" do
  #   Organization.new
  # end


  # attributes from att_accessor - 2.4

  it { is_expected.to respond_to(:agreement_one) }
  it { is_expected.to respond_to(:agreement_two) }
  it { is_expected.to respond_to(:agreement_three) }
  it { is_expected.to respond_to(:agreement_four) }
  it { is_expected.to respond_to(:agreement_five) }
  it { is_expected.to respond_to(:agreement_six) }
  it { is_expected.to respond_to(:agreement_seven) }
  it { is_expected.to respond_to(:agreement_eight) }


  # attributes used in database - 2.4

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


  # associations - 2.6

  it { is_expected.to have_many(:users) }
  it { is_expected.to have_many(:tickets) }
  it { is_expected.to have_and_belong_to_many(:resource_categories) }


  # validations - 3.1
  
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:phone) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_presence_of(:primary_name) }
  it { is_expected.to validate_presence_of(:secondary_name) }
  it { is_expected.to validate_presence_of(:secondary_phone) }
  it { is_expected.to validate_length_of(:email).is_at_least(1).is_at_most(255).on(:create) }
  it { is_expected.to allow_value('user@example.com').for(:email) }
  it { is_expected.not_to allow_value('userexample.com').for(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive}
  it { is_expected.to validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  it { is_expected.to validate_length_of(:description).is_at_most(1020).on(:create) }


  # member functions - 3.2 | factory update - 4.0

  it "can be approved" do
    o = @default_org
    o.approve
    expect(o.status).to eq("approved")
  end

  it "can be rejected" do
    o = @default_org
    o.reject
    expect(o.status).to eq("rejected")
  end

  it "is initialized with submitted status" do
    o = @default_org
    expect(o.status).to eq("submitted")
  end

  it "can set nil status to submitted" do
    o = @default_org
    o.status = nil
    o.set_default_status
    expect(o.status).to eq("submitted")
  end

  it "wont set reset status" do
    o = @default_org
    o.approve
    o.set_default_status
    expect(o.status).to eq("approved")
  end
  
  it "returns its own name" do
    o = @named_org
    expect(o.to_s).to eq("Blue Cross")
  end

end