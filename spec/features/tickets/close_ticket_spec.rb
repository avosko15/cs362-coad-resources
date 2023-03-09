require 'rails_helper'

RSpec.describe 'Closing a ticket', type: :feature do

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
        click_on 'Close'

        expect(page).to have_content 'Closed'
    end

    it 'can be done by an admin' do
        user = create(:user, :admin)
        ticket = create(:ticket, :req_fields_ticket)

        log_in_as(user)

        visit dashboard_path

        click_on 'Sample ticket user name'
        click_on 'Close'

        expect(ticket.reload.open?).to be false
    end

end
