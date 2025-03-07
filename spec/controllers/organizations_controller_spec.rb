require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
    let(:approved_organization) { create(:user, :organization_approved_user) }
    let(:unapproved_organization) { create(:user, :organization_unapproved_user)}
    let(:admin) { create(:user, :admin) }
    let(:organization) { create(:organization)}

    context 'as an approved organization' do
        before(:each) { sign_in(approved_organization) }

        describe "GET #index" do
            it { expect(get(:index)).to be_successful }
        end

        describe "GET #new" do
            it { expect(get(:new)).to redirect_to(dashboard_path)}
        end

        describe "POST #create" do
            it {
                post(:create, params: { organization: attributes_for(:organization) })
                expect(response).to redirect_to(dashboard_path)
            }
        end

        describe "PUT #update" do
            it {
                put(:update, params: { id: organization.id, organization: attributes_for(:organization) })
                expect(response).to redirect_to(organization_path(id: organization.id))
            }

            it {
                expect_any_instance_of(Organization).to receive(:update).and_return(nil)
                put(:update, params: { id: organization.id, organization: attributes_for(:organization) })
                expect(response).to be_successful
            }
            end

        describe "POST #approve" do
            it {
                post(:approve, params: { id: organization.id, organization: attributes_for(:organization) })
                expect(response).to redirect_to(dashboard_path)
            }
        end

        describe "POST #reject" do
            it {
                post(:reject, params: { id: organization.id, organization: attributes_for(:organization) })
                expect(response).to redirect_to(dashboard_path)
            }
        end
    end

    context 'as an unapproved organization' do
        before(:each) { sign_in(unapproved_organization) }

        describe "GET #index" do
            it { expect(get(:index)).to be_successful }
        end

        describe "GET #new" do
            it { expect(get(:new)).to be_successful}
        end
        
        describe "POST #create" do
            it {
                expect_any_instance_of(UserMailer).to receive(:new_organization_application).and_return(false)
                post(:create, params: { id: organization.id, organization: attributes_for(:organization) })
                expect(response).to redirect_to(organization_application_submitted_path)
            }

            it {
                expect_any_instance_of(Organization).to receive(:save).and_return(false)
                post(:create, params: { id: organization.id, organization: attributes_for(:organization) })
                expect(response).to be_successful
            }
        end

        describe "PATCH #update" do
            it {
                patch(:update, params: { id: organization.id, organization: attributes_for(:organization) })
                expect(response).to redirect_to(dashboard_path)
            }
        end

        describe "POST #approve" do
            it {
                post(:approve, params: { id: organization.id, organization: attributes_for(:organization) })
                expect(response).to redirect_to(dashboard_path)
            }
        end

        describe "POST #reject" do
            it {
                post(:reject, params: { id: organization.id, organization: attributes_for(:organization) })
                expect(response).to redirect_to(dashboard_path)
            }
        end
    end


    context 'as a non logged in user' do

        describe "GET #index" do
            it { expect(get(:index)).to redirect_to(new_user_session_path) }
        end

        describe "GET #new" do
            it { expect(get(:new)).to redirect_to(new_user_session_path) }
        end
        
        describe "POST #create" do
            it {
                post(:create, params: { id: organization.id, organization: attributes_for(:organization) })
                expect(response).to redirect_to(new_user_session_path)
            }
        end

        describe "PATCH #update" do
            it {
                patch(:update, params: { id: organization.id, organization: attributes_for(:organization) })
                expect(response).to redirect_to(new_user_session_path)
            }
        end

        describe "POST #approve" do
            it {
                post(:approve, params: { id: organization.id, organization: attributes_for(:organization) })
                expect(response).to redirect_to(new_user_session_path)
            }
        end

        describe "POST #reject" do
            it {
                post(:reject, params: { id: organization.id, organization: attributes_for(:organization) })
                expect(response).to redirect_to(new_user_session_path)
            }
        end
    end

    context 'as an admin' do
        let(:admin) { create(:user, :admin) }
        before(:each) { sign_in(admin) }

        describe "GET #index" do
            it { expect(get(:index)).to be_successful }
        end

        describe "GET #new" do
            it { expect(get(:new)).to redirect_to(dashboard_path) }
        end

        describe "POST #create" do
            it {
                post(:create, params: { id: organization.id, organization: attributes_for(:organization) })
                expect(response).to redirect_to(dashboard_path)
            }
       end

        describe "PATCH #update" do
            it {
                patch(:update, params: { id: organization.id, organization: attributes_for(:organization) })
                expect(response).to redirect_to(dashboard_path)
               }
         end

        describe "POST #approve" do
            it {
                post(:approve, params: { id: organization.id, organization: attributes_for(:organization) })
                expect(response).to redirect_to(organizations_path)
                expect(flash[:notice]).to eq("Organization #{organization.name} has been approved.")
            }

            it {
                expect_any_instance_of(Organization).to receive(:save).and_return(false)
                post(:approve, params: { id: organization.id, organization: attributes_for(:organization) })
                expect(response).to redirect_to(organization_path(id: organization.id))
            }
        end

        describe "POST #reject" do
            it {
                post(:reject, params: { id: organization.id, organization: attributes_for(:organization) })
                expect(response).to redirect_to(organizations_path)
                expect(flash[:notice]).to eq("Organization #{organization.name} has been rejected.")
            }

            it {
                expect_any_instance_of(Organization).to receive(:save).and_return(false)
                post(:reject, params: { id: organization.id, organization: attributes_for(:organization) })
                expect(response).to redirect_to(organization_path(id: organization.id))
            }
        end
    end

end