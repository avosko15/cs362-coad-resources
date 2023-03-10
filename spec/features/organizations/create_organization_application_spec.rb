require 'rails_helper'

RSpec.describe 'Creating an Organization Application', type: :feature do
    it 'can be created by a new user' do
        admin_user = create(:user, :admin)
        user = create(:user)
        log_in_as(user)

        create(:resource_category)

        click_on 'Create Application'

        choose 'organization_liability_insurance_true'
        choose 'organization_agreement_one_true'
        choose 'organization_agreement_two_true'
        choose 'organization_agreement_three_true'
        choose 'organization_agreement_four_true'
        choose 'organization_agreement_five_true'
        choose 'organization_agreement_six_true'
        choose 'organization_agreement_seven_true'
        choose 'organization_agreement_eight_true'
        
        fill_in 'organization_primary_name', with: 'Pugh, Blake'
        fill_in 'organization_name', with: 'Temp Organization'
        fill_in 'organization_title', with: 'Blake the third'
        fill_in 'organization_phone', with: '503-851-0390'
        fill_in "organization_secondary_name", with: "Meeee"
        fill_in 'organization_secondary_phone', with: '555-555-5555'
        fill_in 'organization_email', with: 'test@example2.com'
                
        fill_in 'organization_description', with: 'this is a test'
        
        check 'organization_resource_category_ids_1'

        choose 'organization_transportation_yes'

        click_on 'Apply'

        expect(page).to have_content "Application Submitted"
    end
end