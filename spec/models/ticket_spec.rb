require 'rails_helper'


RSpec.describe Ticket, type: :model do

  # instantiation - 2.2

  # it "exists" do
  #   Ticket.new
  # end


  # attributes used in database - 2.4

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:phone) }
  it { is_expected.to respond_to(:closed) }
  it { is_expected.to respond_to(:closed_at) }


  # associations - 2.6

  it { is_expected.to belong_to(:region) }
  it { is_expected.to belong_to(:resource_category) }
  it { is_expected.to belong_to(:organization).optional }


  # validations - 3.1
  
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


  # member functions - 3.2
  
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


  #imma try the scope test - 3.4

  it "should return only open tickets" do
    Region.create!(id: 10, name: "Test")
    ResourceCategory.create!(id: 10, name: "Test")
    open_ticket = Ticket.create!(name: "Test1", closed: false, region_id: 10, resource_category_id: 10, phone: "+1-555-555-5555")
    closed_ticket = Ticket.create!(name: "Test2", closed: true, region_id: 10, resource_category_id: 10, phone: "+1-555-555-5555")
  
    expect(Ticket.open).to eq([open_ticket])
  end
  
  it "should return only closed tickets" do
    Region.create!(id: 10, name: "Test")
    ResourceCategory.create!(id: 10, name: "Test")
    closed_ticket = Ticket.create!(name: "Test2", closed: true, region_id: 10, resource_category_id: 10, phone: "+1-555-555-5555")
  
    expect(Ticket.closed).to eq([closed_ticket])
  end
  
  it "should return only open tickets with organization ids" do
    Region.create!(id: 10, name: "Test")
    ResourceCategory.create!(id: 10, name: "Test")
    ticket_with_organization1 = Ticket.create!(name: "Test1", organization_id: 1, closed: false, region_id: 10, resource_category_id: 10, phone: "+1-555-555-5555")
    ticket_with_organization2 = Ticket.create!(name: "Test2", organization_id: 1, closed: true, region_id: 10, resource_category_id: 10, phone: "+1-555-555-5555")
    ticket_without_organization = Ticket.create!(name: "Test3", closed: false, region_id: 10, resource_category_id: 10, phone: "+1-555-555-5555")
    expect(Ticket.all_organization).to eq([ticket_with_organization1])
  end
  
  it "should return only open tickets with a specific organization id" do
    Region.create!(id: 10, name: "Test")
    ResourceCategory.create!(id: 10, name: "Test")
    ticket_organization1 = Ticket.create!(name: "Test1", organization_id: 10, closed: false, region_id: 10, resource_category_id: 10, phone: "+1-555-555-5555")
    ticket_organization2 = Ticket.create!(name: "Test2", organization_id: 10, closed: true, region_id: 10, resource_category_id: 10, phone: "+1-555-555-5555")
    ticket_organization3 = Ticket.create!(name: "Test3", organization_id: 9, closed: false, region_id: 10, resource_category_id: 10, phone: "+1-555-555-5555")
    expect(Ticket.organization(10)).to eq([ticket_organization1])
  end
  
  it "should return only closed tickets with a specific organization_id" do
    Region.create!(id: 10, name: "Test")
    ResourceCategory.create!(id: 10, name: "Test")
    ticket_closed_organization1 = Ticket.create!(name: "Test1", organization_id: 10, closed: true, region_id: 10, resource_category_id: 10, phone: "+1-555-555-5555")
    ticket_closed_organization2 = Ticket.create!(name: "Test2", organization_id: 10, closed: false, region_id: 10, resource_category_id: 10, phone: "+1-555-555-5555")
    ticket_closed_organization3 = Ticket.create!(name: "Test3", organization_id: 9, closed: true, region_id: 10, resource_category_id: 10, phone: "+1-555-555-5555")
  
    expect(Ticket.closed_organization(10)).to eq([ticket_closed_organization1])
  end
  
  it "should return only tickets with a specific region id" do
    Region.create!(id: 10, name: "Test1")
    Region.create!(id: 9, name: "Test2")
    ResourceCategory.create!(id: 10, name: "Test")
    ticket_region1 = Ticket.create!(name: "Test1", organization_id: 10, closed: false, region_id: 10, resource_category_id: 10, phone: "+1-555-555-5555")
    ticket_region2 = Ticket.create!(name: "Test2", organization_id: 10, closed: true, region_id: 10, resource_category_id: 10, phone: "+1-555-555-5555")
    ticket_region3 = Ticket.create!(name: "Test3", organization_id: 10, closed: false, region_id: 9, resource_category_id: 10, phone: "+1-555-555-5555")

    expect(Ticket.region(10)).to eq([ticket_region1, ticket_region2])
  end
  
  it "should return only tickets with a specific resource category id" do
    Region.create!(id: 10, name: "Test1")
    ResourceCategory.create!(id: 10, name: "Test1")
    ResourceCategory.create!(id: 9, name: "Test2")
    ticket_resource_category1 = Ticket.create!(name: "Test1", organization_id: 10, closed: false, region_id: 10, resource_category_id: 10, phone: "+1-555-555-5555")
    ticket_resource_category2 = Ticket.create!(name: "Test2", organization_id: 10, closed: true, region_id: 10, resource_category_id: 10, phone: "+1-555-555-5555")
    ticket_resource_category3 = Ticket.create!(name: "Test3", organization_id: 10, closed: false, region_id: 10, resource_category_id: 9, phone: "+1-555-555-5555")
  
    expect(Ticket.resource_category(10)).to eq([ticket_resource_category1, ticket_resource_category2])
  end
  
end