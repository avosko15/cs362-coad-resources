require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
    describe "full title test" do
        it "will print Disaster Resource Network if there's no page title" do
            expect(helper.full_title(page_title = '')).to eq("Disaster Resource Network")
        end
    end
end
