require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
    let(:ticket) { create(:ticket, :req_fields_ticket) }
    
    context 'as a logged-out user' do
        describe 'GET #new' do
            it { expect(get(:new)).to be_successful }
        end

        describe 'POST #create' do
            it {
                post(:create, params: { ticket: attributes_for(:ticket, :req_fields_ticket) })
                expect(response).to redirect_to(ticket_submitted_path) 
            }

            it {
                expect_any_instance_of(Ticket).to receive(:save).and_return(false)
                post(:create, params: { ticket: attributes_for(:ticket, :req_fields_ticket) })
                expect(response).to be_successful
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

    context 'as an admin with org' do
        describe 'POST #release' do
            it {
                # admins can't typically have organizations, so this is a weird test
                # and the code should be fixed
                user = create(:user, :organization_approved_user, :admin)
                sign_in(user)
                ticket.organization_id = user.organization_id
                ticket.save
                post(:release, params: { id: ticket.id })
                expect(response).to redirect_to(dashboard_path << '#tickets:captured')
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
                post(:create, params: { ticket: attributes_for(:ticket, :req_fields_ticket) })
                expect(response).to redirect_to(ticket_submitted_path) 
            }

            it {
                expect_any_instance_of(Ticket).to receive(:save).and_return(false)
                post(:create, params: { ticket: attributes_for(:ticket, :req_fields_ticket) })
                expect(response).to be_successful
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

            it {
                expect(TicketService).to receive(:capture_ticket).and_return(:error)
                post(:capture, params: { id: ticket.id })
                expect(response).to be_successful
            }   
        end

        describe 'POST #release' do
            it {
                post(:release, params: { id: ticket.id })
                expect(response).to be_successful
                # expect(response).to redirect_to(dashboard_path << '#tickets:organization')
            }   

            it {
                expect(TicketService).to receive(:release_ticket).and_return(:error)
                post(:release, params: { id: ticket.id })
                expect(response).to be_successful
            }
        end

        describe 'POST #close' do
            it {
                user = create(:user, :organization_approved_user)
                sign_in(user)
                post(:close, params: { id: user.organization_id })
                expect(response).to be_successful
                expect(response).to redirect_to(dashboard_path << '#tickets:organization')
            } 

            it {
                expect(TicketService).to receive(:close_ticket).and_return(:error)
                post(:close, params: { id: ticket.id })
                expect(response).to be_successful
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
                post(:create, params: { ticket: attributes_for(:ticket, :req_fields_ticket) })
                expect(response).to redirect_to(ticket_submitted_path) 
            }

            it {
                expect_any_instance_of(Ticket).to receive(:save).and_return(false)
                post(:create, params: { ticket: attributes_for(:ticket, :req_fields_ticket) })
                expect(response).to be_successful
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
                post(:create, params: { ticket: attributes_for(:ticket, :req_fields_ticket) })
                expect(response).to redirect_to(ticket_submitted_path) 
            }

            it {
                expect_any_instance_of(Ticket).to receive(:save).and_return(false)
                post(:create, params: { ticket: attributes_for(:ticket, :req_fields_ticket) })
                expect(response).to be_successful
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