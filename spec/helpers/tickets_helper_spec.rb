require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the TIcketsHelper. For example:
#
# describe TIcketsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe TicketsHelper, type: :helper do
    describe "format_phone_number test" do
        it "should apply the US country code to a phone number" do
            expect(helper.format_phone_number("555-555-5555")).to eq("+15555555555")
        end
    end
end
