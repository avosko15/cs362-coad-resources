require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do


  # factory implementation - 4.0

  setup do
    @default_resource_cat = build(:resource_category)
    @default_resource_cat_name = build(:resource_category, :name => "Snow")
    @default_resource_cat_name_unspec = build(:resource_category, :name => "Unspecified")
    @res_cat1 = create(:resource_category, :name => "Test1", :active => true)
    @res_cat2 = create(:resource_category, :name => "Test2", :active => true)
  end
  

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


  # member functions - 3.2 & 4.0

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
    rc = ResourceCategory.unspecified
    expect(rc.name).to eq("Unspecified")
  end


  # scope tests - 3.4 & 4.0
  
  it "can query for active categories" do
    expect(ResourceCategory.active).to contain_exactly(@res_cat1, @res_cat2)
  end

  it "can query for inactive categories" do
    @res_cat1.update_attributes(:active => false)
    @res_cat2.update_attributes(:active => false)
    expect(ResourceCategory.inactive).to contain_exactly(@res_cat1, @res_cat2)
  end
end
