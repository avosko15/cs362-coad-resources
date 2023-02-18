require 'rails_helper'

RSpec.describe RegionsController, type: :controller do
   
    context 'as a logged-in user' do
        let(:user) { create(:user) }
        before(:each) { sign_in(user) }

        let (:region) { create(:region)}

        describe "GET #index" do
            it { expect(get(:index)).to redirect_to(dashboard_path) }
        end

        describe "GET #show" do
            let(:region) { create(:region) }
            it { expect(get(:show, params: { id: region.id } )).to redirect_to(dashboard_path) }
            # some people need dashboard_path to be instead new_session_path
        end 

        describe "GET #new" do
            it { expect(get(:new)).to redirect_to(dashboard_path) }
        end
            
        describe "POST #create" do
            it {
                post(:create, params: { region: attributes_for(:region) })
                expect(response).to redirect_to(dashboard_path)
            }
        end

        describe "GET #edit" do
            let(:region) { create(:region)}
            it {expect(get(:edit, params: {id: region.id} )).to redirect_to(dashboard_path)}
        end

        describe "PUT #update" do
            it {
                put(:update, params: { id: region.id, region: attributes_for(:region) })
                expect(response).to redirect_to(dashboard_path)
            }
        end
    end

    context 'as a logged-out user' do
        let(:user) { create(:user) }
        let (:region) { create(:region)}
        # before(:each) { sign_in(user) }

        describe "GET #index" do
            it { expect(get(:index)).to redirect_to(new_user_session_path) }
        end  

        describe "GET #show" do
            let(:region) { create(:region) }
            it { expect(get(:show, params: { id: region.id } )).to redirect_to(new_user_session_path) }
        end

        describe "GET #new" do
            it { expect(get(:new)).to redirect_to(new_user_session_path) }
        end

        describe "POST #create" do
            it {
                post(:create, params: { region: attributes_for(:region) })
                expect(response).to redirect_to(new_user_session_path)
            }
        end

        describe "GET #edit" do
            let(:region) { create(:region)}
            it {expect(get(:edit, params: {id: region.id} )).to redirect_to(new_user_session_path)}
        end

        describe "PUT #update" do
            it {
                put(:update, params: { id: region.id, region: attributes_for(:region) })
                expect(response).to redirect_to(new_user_session_path)
            }
        end
    end

    context 'as an admin' do
        let(:user) { create(:user, :admin) }
        before(:each) { sign_in(user) }

        let (:region) { create(:region)}

        describe "GET #index" do
            it { expect(get(:index)).to be_successful }
        end

        describe "GET #show" do
            let(:region) { create(:region) }
            it { expect(get(:show, params: { id: region.id })).to be_successful }
        end

        describe "GET #new" do
            it { expect(get(:new)).to be_successful}
        end

        describe "POST #create" do
            # let(:region) { create(:region) }
            it { 
                post(:create, params: { region: attributes_for(:region) })
                expect(response).to redirect_to(regions_path)
            }
        end
        
        describe "GET #edit" do
            let(:region) { create(:region)}
            it {expect(get(:edit, params: {id: region.id} )).to be_successful}
        end

        describe "PUT #update" do
            it {
                put(:update, params: { id: region.id, region: attributes_for(:region) })
                expect(response).to redirect_to(@region)
            }
        end
    
    end

end