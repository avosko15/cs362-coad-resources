require 'rails_helper'

RSpec.describe 'Logging in', type: :feature do
    it 'successfully logsin a user' do
        
        user = create(:user)
        visit dashboard_path
        click_on 'Log in'
    end
end
