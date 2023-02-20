require 'rails_helper'


RSpec.describe Ticket, type: :model do


  # factory implementation - 4.0

  setup do
    @default_ticket = build(:ticket)
    @example_org = create(:organization, :id => 3, :name => "Blue Cross", :email => "example@domain.com", :phone => "555-555-5555", :secondary_phone => "444-444-4444", :primary_name => "Blue Cross", :secondary_name => "BC")
    @example_region = create(:region, :id => 10, :name => "Test")
    @example_region2 = create(:region, :id => 9, :name => "Test2")
    @example_res_cat = create(:resource_category, :id => 10, :name => "Test")
    @example_res_cat2 = create(:resource_category, :id => 9, :name => "Test2")
    @open_ticket = create(:ticket, :name => "Test1", :closed => false, :region_id => 10, :resource_category_id => 10, :phone => "+1-555-555-5555")
    @closed_ticket = create(:ticket, :name => "Test2", :closed => true, :region_id => 10, :resource_category_id => 10, :phone => "+1-555-555-5555")
    @open_ticket2 = create(:ticket, :name => "Test3", :closed => false, :region_id => 10, :resource_category_id => 10, :phone => "+1-555-555-5555")
  end


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


  # member functions - 3.2 & 4.0
  
  it "is open upon creation" do
    t = @default_ticket
    expect(t.open?).to eq(true)
  end

  it "recognizes when ticket is closed" do
    t = @default_ticket
    t.closed = true
    expect(t.open?).to eq(false)
  end

  it "can recognize claimed tickets" do
    @default_ticket.update_attributes(:organization_id => 3) 
    t = @default_ticket
    expect(t.captured?).to eq(true)
  end

  it "is unclaimed upon creation" do
    t = @default_ticket
    expect(t.captured?).to eq(false)
  end

  it "can return its own id" do
    @default_ticket.update_attributes(:id => 50)
    t =  @default_ticket
    expect(t.to_s).to eq("Ticket 50")
  end


  # scope tests - 3.4 & 4.0

  it "should return only open tickets" do
    expect(Ticket.open).to eq([@open_ticket, @open_ticket2])
  end
  
  it "should return only closed tickets" do
    expect(Ticket.closed).to eq([@closed_ticket])
  end
  
  it "should return only open tickets with organization ids" do
    @open_ticket.update_attributes(:organization_id => 10)
    @closed_ticket.update_attributes(:organization_id => 10)
    expect(Ticket.all_organization).to eq([@open_ticket])
  end
  
  it "should return only open tickets with a specific organization id" do
    @open_ticket.update_attributes(:organization_id => 10)
    @closed_ticket.update_attributes(:organization_id => 10)
    @open_ticket2.update_attributes(:organization_id => 9)
    expect(Ticket.organization(10)).to eq([@open_ticket])
  end
  
  it "should return only closed tickets with a specific organization_id" do
    @open_ticket.update_attributes(:organization_id => 10)
    @closed_ticket.update_attributes(:organization_id => 10)
    @open_ticket2.update_attributes(:organization_id => 9)
    expect(Ticket.closed_organization(10)).to eq([@closed_ticket])
  end
  
  it "should return only tickets with a specific region id" do
    @open_ticket2.update_attributes(:region_id => 9)
    expect(Ticket.region(10)).to eq([@open_ticket, @closed_ticket])
  end
  
  it "should return only tickets with a specific resource category id" do
    @open_ticket2.update_attributes(:resource_category_id => 9)
    expect(Ticket.resource_category(10)).to eq([@open_ticket, @closed_ticket])
  end
  
end