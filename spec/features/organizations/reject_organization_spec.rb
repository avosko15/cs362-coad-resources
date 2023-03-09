require 'rails_helper'

RSpec.describe 'Rejecting an organization', type: :feature do

    it 'can be done from the dashboard' do
        user = create(:user, :admin)
        organization = create(:organization) # get an organization ready to be approved
        log_in_as(user)

        visit dashboard_path # Navigate to the dashboard

        click_on 'Organizations'
        click_on 'Pending' # works with or without this line (can find Review before selecting the menu option)
        # if we start having issues with this, use save_and_open_page() to troubleshoot -- if you have multiple Review buttons, can 
        click_on 'Review'
        click_on 'Reject'

        expect(organization.reload.rejected?).to be true
    end

    it 'cannot be done by a non-admin user' do
        organization = create(:organization, :approved)
        not_approved_organization = create(:organization)

        user = create(:user, organization: organization)
        log_in_as(user)

        visit dashboard_path
       
        visit organization_path(id: not_approved_organization.id)
        expect(page).not_to have_content 'Reject'
    end
end
