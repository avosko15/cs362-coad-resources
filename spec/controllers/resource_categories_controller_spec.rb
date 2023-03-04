require 'rails_helper'

RSpec.describe ResourceCategoriesController, type: :controller do
    let(:user) { create(:user) }
    let(:resource_category) { create(:resource_category) }

    context 'as a logged-in user' do
        before(:each) { sign_in(user) }

        describe "GET #index" do
            it { expect(get(:index)).to redirect_to(dashboard_path)}
        end

        describe "GET #show" do
            it { expect(get(:show, params: { id: resource_category.id })).to redirect_to(dashboard_path) }
        end
        
        describe "GET #new" do
            it { expect(get(:new)).to redirect_to(dashboard_path) }
        end

        describe "POST #create" do
            it {
                post(:create, params: { resource_category: attributes_for(:resource_category) })
                expect(response).to redirect_to(dashboard_path)
            }
        end

        describe "GET #edit" do
            it {expect(get(:edit, params: {id: resource_category.id} )).to redirect_to(dashboard_path)}
        end

        describe "PUT #update" do
            it {
                put(:update, params: { id: resource_category.id, resource_category: attributes_for(:resource_category) })
                expect(response).to redirect_to(dashboard_path)
            }
        end

        describe "PATCH #update" do
            it {
                patch(:update, params: { id: resource_category.id, resource_category: attributes_for(:resource_category) })
                expect(response).to redirect_to(dashboard_path)
            }
        end

        describe "DELETE #destroy" do
            it {
                delete(:destroy, params: { id: resource_category.id, resource_category: attributes_for(:resource_category) })
                expect(response).to redirect_to(dashboard_path)
            }
        end

        describe "PATCH #activate" do
            it {
                patch(:activate, params: { id: resource_category.id, resource_category: attributes_for(:resource_category) })
                expect(response).to redirect_to(dashboard_path)
            }
        end

        describe "PATCH #deactivate" do
            it {
                patch(:deactivate, params: { id: resource_category.id, resource_category: attributes_for(:resource_category) })
                expect(response).to redirect_to(dashboard_path)
            }
        end
    end

    context 'as a logged out user' do
        describe "GET #index" do
            it { expect(get(:index)).to redirect_to(new_user_session_path) }
        end

        describe "GET #show" do
            it { expect(get(:show, params: { id: resource_category.id })).to redirect_to(new_user_session_path) }
        end

        describe "GET #new" do
            it { expect(get(:new)).to redirect_to(new_user_session_path) }
        end

        describe "POST #create" do
            it {
                post(:create, params: { resource_category: attributes_for(:resource_category) })
                expect(response).to redirect_to(new_user_session_path)
            }
        end

        describe "GET #edit" do
            it {expect(get(:edit, params: {id: resource_category.id} )).to redirect_to(new_user_session_path)}
        end

        describe "PUT #update" do
            it {
                put(:update, params: { id: resource_category.id, resource_category: attributes_for(:resource_category) })
                expect(response).to redirect_to(new_user_session_path)
            }
        end

        describe "PATCH #update" do
            it {
                patch(:update, params: { id: resource_category.id, resource_category: attributes_for(:resource_category) })
                expect(response).to redirect_to(new_user_session_path)
            }
        end

        describe "DELETE #destroy" do
            it {
                delete(:destroy, params: { id: resource_category.id, resource_category: attributes_for(:resource_category) })
                expect(response).to redirect_to(new_user_session_path)
            }
        end

        describe "PATCH #activate" do
            it {
                patch(:activate, params: { id: resource_category.id, resource_category: attributes_for(:resource_category) })
                expect(response).to redirect_to(new_user_session_path)
            }
        end
        
        describe "PATCH #deactivate" do
        it {
            patch(:deactivate, params: { id: resource_category.id, resource_category: attributes_for(:resource_category) })
            expect(response).to redirect_to(new_user_session_path)
        }
        end
    end

    context 'as an admin' do
        let(:user) { create(:user, :admin) }
        before(:each) { sign_in(user) }

        describe "GET #index" do
            it { expect(get(:index)).to be_successful }
        end

        describe "GET #show" do
            it { expect(get(:show, params: { id: resource_category.id })).to be_successful }
        end

        describe "GET #new" do
            it { expect(get(:new)).to be_successful}
        end
        
        describe "POST #create" do
            it {
                post(:create, params: { resource_category: attributes_for(:resource_category) })
                expect(response).to redirect_to(resource_categories_path)
            }

            it {
                expect_any_instance_of(ResourceCategory).to receive(:save).and_return(false)
                post(:create, params: { resource_category: attributes_for(:resource_category) })
                expect(response).to be_successful
            }
        end

        describe "GET #edit" do
            it {expect(get(:edit, params: {id: resource_category.id} )).to be_successful }
        end

        describe "PUT #update" do
            it {
                put(:update, params: { id: resource_category.id, resource_category: attributes_for(:resource_category) })
                expect(response).to redirect_to(@resource_category)
            }

            it {
                expect_any_instance_of(ResourceCategory).to receive(:update).and_return(false)
                put(:update, params: { id: resource_category.id, resource_category: attributes_for(:resource_category) })
                expect(response).to be_successful
            }
        end
    
        describe "PATCH #update" do
            it {
                patch(:update, params: { id: resource_category.id, resource_category: attributes_for(:resource_category) })
                expect(response).to redirect_to(@resource_category)
            }

            it {
                expect_any_instance_of(ResourceCategory).to receive(:update).and_return(false)
                patch(:update, params: { id: resource_category.id, resource_category: attributes_for(:resource_category) })
                expect(response).to be_successful
            }
        end

        describe "PATCH #activate" do
            it {
                patch(:activate, params: { id: resource_category.id })
                expect(response).to redirect_to(resource_category)
                expect(flash[:notice]).to eq("Category activated.")
            }

            it {
                expect_any_instance_of(ResourceCategory).to receive(:activate).and_return(false)
                patch(:activate, params: { id: resource_category.id })
                expect(response).to redirect_to(resource_category)
                expect(flash[:alert]).to eq("There was a problem activating the category.")
            }
        end

        describe "PATCH #deactivate" do
            it {
                patch(:deactivate, params: { id: resource_category.id, resource_category: attributes_for(:resource_category) })
                expect(response).to redirect_to(resource_category)
                expect(flash[:notice]).to eq("Category deactivated.")
            }

            it {
                expect_any_instance_of(ResourceCategory).to receive(:deactivate).and_return(false)
                patch(:deactivate, params: { id: resource_category.id })
                expect(response).to redirect_to(resource_category)
                expect(flash[:alert]).to eq("There was a problem deactivating the category.")
            }
        end
        
        describe "DELETE #destroy" do
            it {
                delete(:destroy, params: { id: resource_category.id, resource_category: attributes_for(:resource_category) })
                expect(response).to redirect_to(resource_categories_path)
            }
        end
    end

end
