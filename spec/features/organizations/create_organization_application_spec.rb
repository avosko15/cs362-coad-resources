require 'rails_helper'

RSpec.describe 'Creating an Organization Application', type: :feature do
    it 'can be created by a new user' do
        admin_user = create(:user, :admin)
        user = create(:user)
        log_in_as(user)

        visit dashboard_path
        click_on 'Create Application'

        choose 'Yes'
        choose 'I Agree'
        choose 'I Agree'
        choose 'I Agree'
        choose 'I Agree'
        choose 'I Agree'
        choose 'I Agree'
        choose 'I Agree'
        choose 'I Agree'
        
        fill_in 'What is your name?', with: 'Pugh, Blake'
        fill_in 'Organization Name', with: 'Temp Organization'
        fill_in 'What is your direct phone number', with: '503-851-0390'
        fill_in "Who may we contact regarding your organization's application", with: "Meeee"
        fill_in 'What is a good secondary phone number', with: '555-555-5555'
        fill_in "What is your Organization's email?", with: 'test@example.com'
        
        select 'Test', from: 'Select-box'
        
        fill_in 'Description', with: 'this is a test'
        
        choose 'Yes'

        click_on 'Apply'

        # save_and_open_page

        expect(page).to have_content "Application Submitted"
    end
end
