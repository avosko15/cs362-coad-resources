require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
    let(:user) { create(:user) }
    # let (:organization) { create(:organization)}
    #this makes the update test pass in logged in user
     let(:organization) {
        create(:organization,
          name: "imagany org",
          email: "fake@fake.com",
          phone: "+1 (555) 555-5555",
          primary_name: "John Doe",
          secondary_name: "Jane Doe",
          secondary_phone: "+1 (555) 555-5556",
        )
}

    context 'as a logged-in user' do
        before(:each) { sign_in(user) }

        describe "GET #index" do
            it { expect(get(:index)).to be_successful }
        end

        describe "GET #new" do
            it { expect(get(:new)).to be_successful}
        end
        
        # describe "POST #create" do
        #     it {
        #         post(:create, params: { id: organization.id, organization: attributes_for(:organization) })
        #         expect(response).to redirect_to(dashboard_path)
        #     }
        # end

        describe "PUT #update" do
            it {
                put(:update, params: { id: organization.id, organization: attributes_for(:organization) })
                expect(response).to redirect_to(dashboard_path)
            }
        end
        # end
        # describe "POST #approve" do
        #     it {
        #         post(:create, params: { organization: attributes_for(:organization) })
        #         expect(response).to redirect_to(organizations_path)
        #     }
        # end
        # describe "POST #reject" do
        #     it {
        #         post(:create, params: { organization: attributes_for(:organization) })
        #         expect(response).to redirect_to(organizations_path)
        #     }
        # end
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
        # describe "POST #approve" do
        #     it {
        #         post(:create, params: { organization: attributes_for(:organization) })
        #         expect(response).to redirect_to(organizations_path)
        #     }
        # end
        # describe "POST #reject" do
        #     it {
        #         post(:create, params: { organization: attributes_for(:organization) })
        #         expect(response).to redirect_to(organizations_path)
        #     }
        # end
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

        # describe "POST #create" do
        #     it {
        #         post(:create, params: { id: organization: attributes_for(:organization) })
        #         expect(response).to redirect_to(organization_path)
        #     }
        # end
         describe "PATCH #update" do
                it {
                    patch(:update, params: { id: organization.id, organization: attributes_for(:organization) })
                    expect(response).to redirect_to(dashboard_path)
                }
            end
        # describe "POST #approve" do
        #     it {
        #         post(:create, params: { organization: attributes_for(:organization) })
        #         expect(response).to redirect_to(organizations_path)
        #     }
        # end
        # describe "POST #reject" do
        #     it {
        #         post(:create, params: { organization: attributes_for(:organization) })
        #         expect(response).to redirect_to(organizations_path)
        #     }
        # end
    end

end