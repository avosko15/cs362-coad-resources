require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the DashboardHelper. For example:
#
# describe DashboardHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end

RSpec.describe DashboardHelper, type: :helper do

    context "admin" do
        # let(:user) { build(:user, :admin) }
        let(:user) { instance_double('User', admin?: true) } # makes fake object w same attributes
        # let(:user) { double('User', admin?: true) } # makes fake object w only specified attributes

        describe "gets the admin_dashboard" do
            it { expect(helper.dashboard_for(user)).to eq 'admin_dashboard' }
        end
    end

    context "organization submitted" do
        let(:user) { instance_double('User', admin?: false, organization: Organization.new(status: :submitted)) } # a third way of making this happen

        describe "gets the organization_submitted_dashboard" do
            it { expect(helper.dashboard_for(user)).to eq 'organization_submitted_dashboard'}
        end
    end

    context "organization approved" do
        let(:user) { instance_double('User', admin?: false, organization: Organization.new(status: :approved)) } # a third way of making this happen

        describe "gets the organization_approved_dashboard" do
            it { expect(helper.dashboard_for(user)).to eq 'organization_approved_dashboard'}
        end
    end

    context "non-logged in user" do
        let(:user) { instance_double('User', admin?: false, organization: nil) } # a third way of making this happen

        describe "gets the create_application_dashboard" do
            it { expect(helper.dashboard_for(user)).to eq 'create_application_dashboard'}
        end
    end

end
