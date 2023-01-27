require 'rails_helper'

RSpec.describe Ticket, type: :model do

  # it "exists" do
  #   Ticket.new
  # end

  it "is open upon creation" do
    t = Ticket.new
    expect(t.open?).to eq(true)
  end

  it "recognizes when ticket is closed" do
    t = Ticket.new
    t.closed = true
    expect(t.open?).to eq(false)
  end

  it "can recognize claimed tickets" do
    o = Organization.create(id: 3, name: "Blue Cross", email: "example@domain.com", phone: "555-555-5555", secondary_phone: "444-444-4444", primary_name: "Blue Cross", secondary_name: "BC")
    t = Ticket.new(organization_id: 3)
    expect(t.captured?).to eq(true)
  end

  it "is unclaimed upon creation" do
    t = Ticket.new
    expect(t.captured?).to eq(false)
  end

  it "can return its own id" do
    t = Ticket.new(id: 50)
    expect(t.to_s).to eq("Ticket 50")
  end

  # attributes used in database
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:phone) }
  it { is_expected.to respond_to(:closed) }
  it { is_expected.to respond_to(:closed_at) }

  # associations
  it { is_expected.to belong_to(:region) }
  it { is_expected.to belong_to(:resource_category) }
  it { is_expected.to belong_to(:organization).optional }

  # validations
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:phone) }
  it { is_expected.to validate_presence_of(:region_id) }
  it { is_expected.to validate_presence_of(:resource_category_id) }
  it { is_expected.to validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
  it { is_expected.to validate_length_of(:description).is_at_most(1020).on(:create) }
  it { is_expected.to allow_value('+1 503 344 4567').for(:phone) }
  it { is_expected.not_to allow_value('userexample.com').for(:phone) }
  # it { is_expected.to validate_plausible_phone(:phone) }

end
