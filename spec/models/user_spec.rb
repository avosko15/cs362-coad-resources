require 'rails_helper'

RSpec.describe User, type: :model do

  # it "exists" do
  #   User.new
  # end

  # attributes used in database
  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:role) }

  # associations
  it { is_expected.to belong_to(:organization).optional }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_least(1).is_at_most(255).on(:create) }
  # validates :email, format: { with: VALID_EMAIL_REGEX }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_presence_of(:password).on(:create) }
  it { is_expected.to validate_length_of(:password).is_at_least(7).is_at_most(255).on(:create) }

end
