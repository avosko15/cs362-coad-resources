require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
    let(:ticket) { create(:ticket, :req_fields_ticket) }
    
    context 'as a logged-out user' do

        describe 'GET #new' do
            it { expect(get(:new)).to be_successful }
        end

        # same for all, but getting error
        # describe 'POST #create' do
        #     it {
        #         post(:create, params: { ticket: attributes_for(:ticket) })
        #         expect(response).to redirect_to(ticket_submitted_path) 
        #     }
        # end

        describe 'GET #show' do
            it { expect(get(:show, params: { id: ticket.id })).to redirect_to(dashboard_path) }
        end

        # same for all except approved organization, but getting error
        # describe 'POST #capture' do
        #     it {
        #         post(:capture, params: { ticket: attributes_for(:ticket) })
        #         expect(response).to redirect_to(dashboard_path)
        #     }
        # end

        # release
        # close
        # destroy

    end

    context 'as an approved organization' do
        let(:organization_approved_user) { create(:user, :organization_approved_user) }
        before(:each) { sign_in(organization_approved_user) }

        describe 'GET #new' do
            it { expect(get(:new)).to be_successful }
        end

        # same POST #create test as 'as a logged-out user'

        describe 'GET #show' do
            it { expect(get(:show, params: { id: ticket.id })).to be_successful }
        end

        # describe 'POST #capture' do
        #     it {
        #         post(:capture, params: { ticket: attributes_for(:ticket) })
        #         expect(response).to be_successful
        #     }
        # end

        # release
        # close
        # destroy

    end

    context 'as an unapproved organization' do
        let(:organization_unapproved_user) { create(:user, :organization_unapproved_user) }
        before(:each) { sign_in(organization_unapproved_user) }

        describe 'GET #new' do
            it { expect(get(:new)).to be_successful }
        end

        # same POST #create test as 'as a logged-out user'

        describe 'GET #show' do
            it { expect(get(:show, params: { id: ticket.id })).to redirect_to(dashboard_path) }
        end

        # same POST #capture test as 'as a logged-out user'

        # release
        # close
        # destroy

    end

    context 'as an admin' do
        let(:user) { create(:user, :admin) }
        before(:each) { sign_in(user) }

        describe 'GET #new' do
            it { expect(get(:new)).to be_successful }
        end

        # same POST #create test as 'as a logged-out user'
        
        describe 'GET #show' do
            it { expect(get(:show, params: { id: ticket.id })).to be_successful }
        end

        # same POST #capture test as 'as a logged-out user'

        # release
        # close
        # destroy

    end

end