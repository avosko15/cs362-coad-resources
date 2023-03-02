require 'rails_helper'

RSpec.describe 'Creating a Region', type: :feature do

    let(:admin) { create(:user, :admin) }

    it 'successfully creates a new region' do
        log_in_as(admin)

        visit new_region_path

        fill_in 'Name', with: 'SOME FAKE REGION'
        click_on 'Add Region'
        expect(current_path).to eq regions_path
        expect(page).to have_text('SOME FAKE REGION')
    end

end
