require 'rails_helper'

RSpec.describe 'User registration', type: :feature do

    it 'successfully regigisters a new user' do
        user = create(:user)
        visit dashboard_path
        find("a[href='#{"/signup"}']").click
        #click_on(href: 'Sign up')
        fill_in 'Email address', with: 'test@fakeassemail.com'
        fill_in 'Password', with: 'beepbeep'
        fill_in 'Password confirmation', with: 'beepbeep' 
        #expect_any_instance_of(RegistrationsController).to receive(check_captcha).and_return(true)
        click_on 'commit'
    
    end
end
