require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  # it "exists" do
  #   ResourceCategory.new
  # end

  it "is initialized as active" do
    r = ResourceCategory.new
    expect(r.active).to eq(true)
  end

  it "can be deactivated" do
    r = ResourceCategory.new
    r.deactivate
    expect(r.active).to eq(false)
  end

  it "recognizes its own activity" do
    r = ResourceCategory.new
    expect(r.inactive?).to eq(false)
  end

  it "recognizes its own inactivity" do
    r = ResourceCategory.new
    r.deactivate
    expect(r.inactive?).to eq(true)
  end

  it "can display its own name" do 
    r = ResourceCategory.new(name: "Snow")
    expect(r.to_s).to eq("Snow")
  end

  # attributes used in database
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:active) }

  # associations
  it { is_expected.to have_and_belong_to_many(:organizations) }
  it { is_expected.to have_many(:tickets) }

  # validations
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }

    #3.4 Anna trying to do scope test
  it "can query for active catagories" do
    active1 = ResourceCategory.create!(name: "Test1", active: true)
    active2 = ResourceCategory.create!(name: "Test2", active: true)
    inactive = ResourceCategory.create!(name: "Inactive", active: false)
   
    expect(ResourceCategory.active).to contain_exactly(active1, active2)
  end

end
