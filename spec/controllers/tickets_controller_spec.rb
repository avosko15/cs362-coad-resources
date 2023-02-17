require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
    let(:ticket) { create(:ticket, :req_fields_ticket) }
    let(:organization_approved_user) { create(:user, :organization_approved_user) }
    let(:organization_unapproved_user) { create(:user, :organization_unapproved_user) }
    
    describe 'GET #new' do
        it { expect(get(:new)).to be_successful }
    end

    describe 'GET #show' do
        before do
            sign_in organization_approved_user
        end

        it { expect(get(:show, params: { id: ticket.id })).to be_successful }
    end

    # more
end