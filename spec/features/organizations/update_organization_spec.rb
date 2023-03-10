require 'rails_helper'

RSpec.describe 'Updating an Organization', type: :feature do
    it "can be done by an approved organization" do
        user = create(:user, :organization_approved_user)
        log_in_as(user)

        visit dashboard_path
        click_on 'Edit Organization'

        fill_in 'organization_name', with: 'edited organization'

        click_on 'Update Resource'

        # This test seems useless, but there's nothing else in the
        # edit method to test so I thought I'd put something in here.
        expect(page).to have_content 'edited organization'
    end

    it 'cannot be done by an unapproved organization' do
        user = create(:user, :organization_unapproved_user)
        log_in_as(user)

        visit dashboard_path
        expect(page).not_to have_content 'Edit Organization'
    end
        
    
end
