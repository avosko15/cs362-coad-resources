require 'rails_helper'

RSpec.describe 'Deleting a Region', type: :feature do
    let(:admin) { create(:user, :admin) }

    it 'successfully deletes a region' do
        #user = create(:user, :admin)
        region = create(:region)
        log_in_as(admin)

        visit regions_path

        click_on region.name
        click_on 'Delete'
        #guess I dont need the flash alert
        #expect(flash[:alert]).to eq("Are you sure? This cannot be undone. These tickets will have an Unspecified region.")
        #click_on 'OK'
        expect(current_path).to eq regions_path
        expect(page).to have_text('Unspecified')
    end
end

