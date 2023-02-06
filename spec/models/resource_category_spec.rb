require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  setup do
    @default_resource_cat = build(:resource_category)
    @default_resource_cat_name = build(:resource_category, :name => "Snow")
    @default_resource_cat_name_unspec =build(:resource_category, :name => "Unspecified")
  end
  let(:resource_category) {build(:resource_category)}
  # instantiation - 2.2

  # it "exists" do
  #   ResourceCategory.new
  # end


  # attributes used in database - 2.4

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:active) }


  # associations - 2.6

  it { is_expected.to have_and_belong_to_many(:organizations) }
  it { is_expected.to have_many(:tickets) }


  # validations - 3.1

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }


  # member functions - 3.2

  it "is initialized as active" do
    r = @default_resource_cat
    expect(r.active).to eq(true)
  end

  it "can be deactivated" do
    r = @default_resource_cat
    r.deactivate
    expect(r.active).to eq(false)
  end

  it "recognizes its own activity" do
    r = @default_resource_cat
    expect(r.inactive?).to eq(false)
  end

  it "recognizes its own inactivity" do
    r = @default_resource_cat
    r.deactivate
    expect(r.inactive?).to eq(true)
  end

  it "can display its own name" do 
    r = @default_resource_cat_name
    expect(r.to_s).to eq("Snow")
  end


  # class functions - 3.3

  it "can find or create ResourceCategory record with name 'Unspecified'" do
    rc = @default_resource_cat_name_unspec
    expect(rc.name).to eq("Unspecified")
  end


  # 3.4 Anna trying to do scope test
  
  it "can query for active categories" do
    active1 = ResourceCategory.create!(name: "Test1", active: true)
    active2 = ResourceCategory.create!(name: "Test2", active: true)
   
    expect(ResourceCategory.active).to contain_exactly(active1, active2)
  end

  it "can query for inactive categories" do
    inactive1 = ResourceCategory.create!(name: "Test1", active: false)
    inactive2 = ResourceCategory.create!(name: "Test2", active: false)

    expect(ResourceCategory.inactive).to contain_exactly(inactive1, inactive2)
  end
end
