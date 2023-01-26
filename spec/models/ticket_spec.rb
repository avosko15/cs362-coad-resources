require 'rails_helper'

RSpec.describe Ticket, type: :model do

  # it "exists" do
  #   Ticket.new
  # end

  # attributes used in database
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:phone) }
  it { is_expected.to respond_to(:closed) }
  it { is_expected.to respond_to(:closed_at) }

end
