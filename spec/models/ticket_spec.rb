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
  # it { is_expected.to validate_plausible_phone(:phone) } - added by E, we can take this out eventually but Beej is 
  #     investigating so leave it for now

  #imma try the scope test 

  it "should return only open resources" do
    open_resource = Resource.create(closed: false, organization_id: nil)
    closed_resource = Resource.create(closed: true)
  
    expect(Resource.open).to eq([open_resource])
  end
  
  it "should return only closed resources" do
    closed_resource = Resource.create(closed: true)
  
    expect(Resource.closed).to eq([closed_resource])
  end
  
  it "should return only resources where organization_id is not nil" do
    all_organization_resource = Resource.create(closed: false, organization_id: 1)
  
    expect(Resource.all_organization).to eq([all_organization_resource])
  end
  
  it "should return only resources where organization_id is the specified value and closed is false" do
    organization_resource = Resource.create(organization_id: 1, closed: false)
  
    expect(Resource.organization(1)).to eq([organization_resource])
  end
  
  it "should return only resources where organization_id is the specified value and closed is true" do
    closed_organization_resource = Resource.create(organization_id: 1, closed: true)
  
    expect(Resource.closed_organization(1)).to eq([closed_organization_resource])
  end
  
  it "should return only resources where region_id is the specified value" do
    region_resource = Resource.create(region_id: 1)
  
    expect(Resource.region(1)).to eq([region_resource])
  end
  
  it "should return only resources where resource_category_id is the specified value" do
    resource_category_resource = Resource.create(resource_category_id: 1)
  
    expect(Resource.resource_category(1)).to eq([resource_category_resource])
  end
  
end