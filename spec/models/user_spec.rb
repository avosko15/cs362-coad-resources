require 'rails_helper'

RSpec.describe User, type: :model do

  # it "exists" do
  #   User.new
  # end

  # attributes used in database
  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:role) }

end
