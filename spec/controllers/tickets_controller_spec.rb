require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
    let(:ticket) { create(:ticket, :req_fields_ticket) }
    
    context 'as a logged-out user' do

        describe 'GET #new' do
            it { expect(get(:new)).to be_successful }
        end

        describe 'POST #create' do
            it {
                post(:create, params: { ticket: ticket.as_json })
                expect(response).to redirect_to(ticket_submitted_path) 
            }
        end

        describe 'GET #show' do
            it { expect(get(:show, params: { id: ticket.id })).to redirect_to(dashboard_path) }
        end

        describe 'POST #capture' do
            it {
                post(:capture, params: { id: ticket.id })
                expect(response).to redirect_to(dashboard_path)
            }   
        end

        describe 'POST #release' do
            it {
                post(:capture, params: { id: ticket.id })
                expect(response).to redirect_to(dashboard_path)
            }   
        end

        describe 'POST #close' do
            it {
                post(:close, params: { id: ticket.id })
                expect(response).to redirect_to(dashboard_path)
            }   
        end

        describe 'POST #destroy' do
            it {
                expect(delete(:destroy, params: { id: ticket.id })).to redirect_to(dashboard_path)
            }   
        end

    end

    context 'as an approved organization' do
        let(:organization_approved_user) { create(:user, :organization_approved_user) }
        before(:each) { sign_in(organization_approved_user) }

        describe 'GET #new' do
            it { expect(get(:new)).to be_successful }
        end

        describe 'POST #create' do
            it {
                post(:create, params: { ticket: ticket.as_json })
                expect(response).to redirect_to(ticket_submitted_path) 
            }
        end

        describe 'GET #show' do
            it { expect(get(:show, params: { id: ticket.id })).to be_successful }
        end

        describe 'POST #capture' do
            it {
                post(:capture, params: { id: ticket.id })
                expect(response).to redirect_to(dashboard_path << '#tickets:open')
            }   
        end

        describe 'POST #release' do
            it {
                post(:release, params: { id: ticket.id })
                expect(response).to be_successful
                # expect(response).to redirect_to(dashboard_path << '#tickets:organization')
            }   
        end

        describe 'POST #close' do
            it {
                post(:close, params: { id: ticket.id })
                expect(response).to be_successful
                # expect(response).to redirect_to(dashboard_path << '#tickets:organization')
            }   
        end
        
        describe 'POST #destroy' do
            it {
                expect(delete(:destroy, params: { id: ticket.id })).to redirect_to(dashboard_path)
            }   
        end

    end

    context 'as an unapproved organization' do
        let(:organization_unapproved_user) { create(:user, :organization_unapproved_user) }
        before(:each) { sign_in(organization_unapproved_user) }

        describe 'GET #new' do
            it { expect(get(:new)).to be_successful }
        end

        describe 'POST #create' do
            it {
                post(:create, params: { ticket: ticket.as_json })
                expect(response).to redirect_to(ticket_submitted_path) 
            }
        end

        describe 'GET #show' do
            it { expect(get(:show, params: { id: ticket.id })).to redirect_to(dashboard_path) }
        end

        describe 'POST #capture' do
            it {
                post(:capture, params: { id: ticket.id })
                expect(response).to redirect_to(dashboard_path)
            }   
        end

        describe 'POST #release' do
            it {
                post(:capture, params: { id: ticket.id })
                expect(response).to redirect_to(dashboard_path)
            }   
        end

        describe 'POST #close' do
            it {
                post(:close, params: { id: ticket.id })
                expect(response).to redirect_to(dashboard_path)
            }   
        end
        
        describe 'POST #destroy' do
            it {
                expect(delete(:destroy, params: { id: ticket.id })).to redirect_to(dashboard_path)
            }   
        end

    end

    context 'as an admin' do
        let(:user) { create(:user, :admin) }
        before(:each) { sign_in(user) }

        describe 'GET #new' do
            it { expect(get(:new)).to be_successful }
        end

        describe 'POST #create' do
            it {
                post(:create, params: { ticket: ticket.as_json })
                expect(response).to redirect_to(ticket_submitted_path) 
            }
        end        

        describe 'GET #show' do
            it { expect(get(:show, params: { id: ticket.id })).to be_successful }
        end

        describe 'POST #capture' do
            it {
                post(:capture, params: { id: ticket.id })
                expect(response).to redirect_to(dashboard_path)
            }   
        end

        describe 'POST #release' do
            it {
                post(:capture, params: { id: ticket.id })
                expect(response).to redirect_to(dashboard_path)
            }   
        end        
        
        describe 'POST #close' do
            it {
                post(:close, params: { id: ticket.id })
                expect(response).to redirect_to(dashboard_path << '#tickets:open')
            }   
        end
        
        describe 'POST #destroy' do
            it {
                expect(delete(:destroy, params: { id: ticket.id })).to redirect_to(dashboard_path << '#tickets')
            }   
        end

    end

end