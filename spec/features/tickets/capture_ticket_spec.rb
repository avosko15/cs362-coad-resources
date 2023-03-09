require 'rails_helper'

RSpec.describe 'Capturing a ticket', type: :feature do

    it 'can be captured by an approved organization' do
        user = create(:user, :organization_approved_user)
        ticket = create(:ticket, :req_fields_ticket)

        log_in_as(user)

        visit dashboard_path

        click_on 'Tickets'
        click_on 'Sample ticket user name'
        click_on 'Capture'

        expect(ticket.reload.captured?).to be true
    end

    it 'cannot be captured by an unapproved organization' do
        user = create(:user, :organization_unapproved_user)
        ticket = create(:ticket, :req_fields_ticket)

        log_in_as(user)

        visit dashboard_path

        expect(page).not_to have_content('Tickets')
    end
    
end
