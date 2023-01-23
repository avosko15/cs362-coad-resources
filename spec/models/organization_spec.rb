require 'rails_helper'

RSpec.describe Organization, type: :model do

  # it "exists" do
  #   Organization.new
  # end

  it { is_expected.to respond_to(:name) }

end
