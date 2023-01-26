require 'rails_helper'

RSpec.describe User, type: :model do

  # it "exists" do
  #   User.new
  # end

  it "returns its own email" do
    u = User.new(email: "bario54321@gmail.com")
    expect(u.to_s).to eq("bario54321@gmail.com")
  end

  it "has an role on creation" do
    u = User.new
    expect(u.role).to eq("organization")
  end

  it "can have a nil role" do
    u = User.new
    u.role = nil
    expect(u.role).to eq(nil)
  end

  it "can set nil role to organization" do
    u = User.new
    u.role = nil
    u.set_default_role
    expect(u.role).to eq("organization")
  end

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
