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

end
