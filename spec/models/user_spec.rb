require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) {build(:user)}

  # instantiation - 2.2

  # it "exists" do
  #   User.new
  # end


  # attributes used in database - 2.4

  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:role) }


  # associations - 2.6

  it { is_expected.to belong_to(:organization).optional }


  # validations - 3.1
  
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_least(1).is_at_most(255).on(:create) }
  it { is_expected.to allow_value('user@example.com').for(:email) }
  it { is_expected.not_to allow_value('userexample.com').for(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_presence_of(:password).on(:create) }
  it { is_expected.to validate_length_of(:password).is_at_least(7).is_at_most(255).on(:create) }


  # member functions - 3.2
  
  it "returns its own email" do
    expect(user.to_s).to eq("bario54321@gmail.com")
  end

  it "has an role on creation" do
    expect(user.role).to eq("organization")
  end

  it "can have a nil role" do
    user.role = nil
    expect(user.role).to eq(nil)
  end

  it "can set nil role to organization" do
    user.role = nil
    user.set_default_role
    expect(user.role).to eq("organization")
  end

  it "won't change default role" do
    user.set_default_role
    expect(user.role).to eq("organization")
  end

end
