require 'rails_helper'

RSpec.describe ResourceCategoriesController, type: :controller do
    context 'as a logged-in user' do
        let(:user) { create(:user) }
        before(:each) { sign_in(user) }

        let(:resource_category) { create(:resource_category) }

        describe "GET #index" do
            it { expect(get(:index)).to redirect_to(dashboard_path)}
        end
    end

end
