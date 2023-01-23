require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  # it "exists" do
  #   ResourceCategory.new
  # end

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:active) }


end
