require 'rails_helper'

RSpec.describe Region, type: :model do

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

  it "returns its own name" do
    r = Region.new(name: "Sisters")
    expect(r.to_s).to eq("Sisters")
  end

  # attributes used in database
  it { is_expected.to respond_to(:name) }

  # associations
  it { is_expected.to have_many(:tickets) }
  
  # validations
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }

end
