require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  # it "exists" do
  #   ResourceCategory.new
  # end

  # attributes used in database
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:active) }

  # associations
  it { is_expected.to have_and_belong_to_many(:organizations) }
  it { is_expected.to have_many(:tickets) }


end
