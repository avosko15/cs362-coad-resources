require 'rails_helper'

RSpec.describe RegionsController, type: :controller do
   
    let(:region) { create(:region)}
    let(:user) { create(:user) }


    context 'as a logged-in user' do
        before(:each) { sign_in(user) }

        describe "GET #index" do
            it { expect(get(:index)).to redirect_to(dashboard_path) }
        end

        describe "GET #show" do
            it { expect(get(:show, params: { id: region.id } )).to redirect_to(dashboard_path) }
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
            it {expect(get(:edit, params: {id: region.id} )).to redirect_to(dashboard_path)}
        end

        describe "PUT #update" do
            it {
                put(:update, params: { id: region.id, region: attributes_for(:region) })
                expect(response).to redirect_to(dashboard_path)
            }
        end

        describe "DELETE #destroy" do
            it {
                delete(:destroy, params: { id: region.id, region: attributes_for(:region) })
                expect(response).to redirect_to(dashboard_path)
            }
        end
    end

    context 'as a logged-out user' do

        describe "GET #index" do
            it { expect(get(:index)).to redirect_to(new_user_session_path) }
        end  

        describe "GET #show" do
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
            it {expect(get(:edit, params: {id: region.id} )).to redirect_to(new_user_session_path)}
        end

        describe "PUT #update" do
            it {
                put(:update, params: { id: region.id, region: attributes_for(:region) })
                expect(response).to redirect_to(new_user_session_path)
            }
        end

        describe "DELETE #destroy" do
            it {
                delete(:destroy, params: { id: region.id, region: attributes_for(:region) })
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
            it { expect(get(:show, params: { id: region.id })).to be_successful }
        end

        describe "GET #new" do
            it { expect(get(:new)).to be_successful}
        end

        describe "POST #create" do
            it { 
                post(:create, params: { region: attributes_for(:region) })
                expect(response).to redirect_to(regions_path)
            }

            it { 
                expect_any_instance_of(Region).to receive(:save).and_return(false)
                post(:create, params: { region: attributes_for(:region) })
                expect(response).to be_successful
            }
        end
        
        describe "GET #edit" do
            it {expect(get(:edit, params: {id: region.id} )).to be_successful}
        end

        describe "PUT #update" do
            it {
                put(:update, params: { id: region.id, region: attributes_for(:region) })
                expect(response).to redirect_to(@region)
            }

            it {
                expect_any_instance_of(Region).to receive(:update).and_return(false)
                put(:update, params: { id: region.id, region: attributes_for(:region) })
                expect(response).to be_successful
            }
        end
    
        describe "DELETE #destroy" do
            it {
                delete(:destroy, params: { id: region.id, region: attributes_for(:region) })
                expect(response).to redirect_to(regions_path)
            }
        end
    end

end