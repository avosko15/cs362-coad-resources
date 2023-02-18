require 'rails_helper'

RSpec.describe Region, type: :model do

  
  # factory implementation - 4.0

  let(:region) {build(:region)}


  # instantiation - 2.2

  # it "exists" do
  #   Region.new
  # end

  # it "has a name" do
  #   region = Region.new
  #   expect(region).to respond_to(:name)
  # end

  # it "has a string representation that is its name" do
  #   name = 'Mt. Hood'
  #   region = Region.new(name: name)
  #   result = region.to_s
  # end


  # attributes used in database - 2.4

  it { is_expected.to respond_to(:name) }


  # associations - 2.6

  it { is_expected.to have_many(:tickets) }
  

  # validations - 3.1

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }


  # member functions - 3.2 & 4.0

  it "returns its own name" do
    expect(region.to_s).to eq(region.name)
  end


  # class functions - 3.3
  
  it "can find or create Region record with name 'Unspecified'" do
    r = Region.unspecified
    expect(r.name).to eq("Unspecified")
  end

end
