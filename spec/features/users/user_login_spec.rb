require 'rails_helper'

RSpec.describe 'Logging in', type: :feature do
    it 'successfully logsin a user' do
        user = create(:user)
        visit dashboard_path
        find("a[href='#{"/login"}']").click
        fill_in 'Email address', with: 'test@fakeassemail.com'
        fill_in 'Password', with: 'beepbeep'
        click_on 'commit'
    end
end
