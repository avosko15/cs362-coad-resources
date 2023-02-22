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
        end
    end

end
