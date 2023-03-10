require 'rails_helper'

RSpec.describe 'Deleting a Resource Category', type: :feature do
    let(:admin) { create(:user, :admin) }

    it 'successfully deletes a resource category' do
        
        resource_category = create(:resource_category)
        log_in_as(admin)
        visit resource_categories_path
        click_on resource_category.name
        click_on 'Delete'
        expect(current_path).to eq resource_categories_path
        expect(page).to have_text('Unspecified')
    end
end
