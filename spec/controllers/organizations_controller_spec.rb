require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
    let(:user) { create(:user) }
    let(:organization) { create(:organization)}

    context 'as a logged-in user' do
        before(:each) { sign_in(user) }

        describe "GET #index" do
            it { expect(get(:index)).to be_successful }
        end

        describe "GET #new" do
            it { expect(get(:new)).to be_successful}
        end
        
        describe "POST #create" do
            it {
                expect_any_instance_of(UserMailer).to receive(:new_organization_application).and_return(nil)
                post(:create, params: { organization: attributes_for(:organization) })
                expect(response).to redirect_to(organization_application_submitted_path)
            }
        end
        describe "PUT #update" do
            it {
                put(:update, params: { id: organization.id, organization: attributes_for(:organization) })
                expect(response).to redirect_to(dashboard_path)
            }

            # it {
            #     expect_any_instance_of(Organization).to receive(:update).and_return(nil)
            #     put(:update, params: { id: organization.id, organization: attributes_for(:organization) })
            #     expect(response).to be_successful
            # }
        end
   
        describe "POST #approve" do
            it {
                expect_any_instance_of(UserMailer).to receive(:new_organization_application).and_return(nil)
                post(:create, params: { organization: attributes_for(:organization) })
                expect(response).to redirect_to(organization_application_submitted_path)
            }
        end

        describe "POST #reject" do
            it {
                expect_any_instance_of(UserMailer).to receive(:new_organization_application).and_return(nil)
                post(:create, params: { organization: attributes_for(:organization) })
                expect(response).to redirect_to(organization_application_submitted_path)
            }
        end
    end


    context 'as a logged out user' do
        describe "GET #index" do
            it { expect(get(:index)).to redirect_to(new_user_session_path) }
        end

        describe "GET #new" do
            it { expect(get(:new)).to redirect_to(new_user_session_path) }
        end
        
        describe "POST #create" do
             it {
                post(:create, params: { organization: attributes_for(:organization) })
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
                post(:create, params: { organization: attributes_for(:organization) })
                expect(response).to redirect_to(new_user_session_path)
            }
        end

        describe "POST #reject" do
            it {
                post(:create, params: { organization: attributes_for(:organization) })
                expect(response).to redirect_to(new_user_session_path)
            }
        end
    end

    context 'as an admin' do
        let(:admin) { create(:user, :admin) }
        before(:each) { sign_in(user) }

        describe "GET #index" do
            it { expect(get(:index)).to be_successful }
        end

        describe "GET #new" do
            it { expect(get(:new)).to be_successful}
        end

        describe "POST #create" do
            it {
                expect_any_instance_of(UserMailer).to receive(:new_organization_application).and_return(nil)
                post(:create, params: { organization: attributes_for(:organization) })
                expect(response).to redirect_to(organization_application_submitted_path)
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
                expect_any_instance_of(UserMailer).to receive(:new_organization_application).and_return(nil)
                post(:create, params: { organization: attributes_for(:organization) })
                expect(response).to redirect_to(organization_application_submitted_path)
            }
        end
        describe "POST #reject" do
            it {
                expect_any_instance_of(UserMailer).to receive(:new_organization_application).and_return(nil)
                post(:create, params: { organization: attributes_for(:organization) })
                expect(response).to redirect_to(organization_application_submitted_path)
            }
        end
    end

end