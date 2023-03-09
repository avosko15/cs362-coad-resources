require 'rails_helper'

RSpec.describe 'Releasing a ticket', type: :feature do

    it 'can be done by an approved organization' do
        user = create(:user, :organization_approved_user)
        ticket = create(:ticket, :req_fields_ticket)

        log_in_as(user)

        visit dashboard_path

        click_on 'Tickets'
        click_on 'Sample ticket user name'
        click_on 'Capture'

        visit dashboard_path

        click_on 'Tickets'
        click_on 'Sample ticket user name'
        click_on 'Release'

        visit dashboard_path

        click_on 'Tickets'
        click_on 'Sample ticket user name'

        expect('Captured by').to_not have_content(user.organization.name)
    end

end
