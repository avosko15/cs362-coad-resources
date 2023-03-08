# factory implementation - 4.0

FactoryBot.define do
    factory :user do
        sequence :email do |n|
            "fake#{n}@example.com"
        end

        password { "fake_password" }

        before(:create) { |user| user.skip_confirmation! }

        trait :organization_approved_user do
            role { :organization }
            organization_id { create(:organization, :approved).id }
        end

        trait :organization_unapproved_user do
            role { :organization }
            # organization_id { create(:organization).id }  # made this also a req_fields_organization, can change back if breaks things
        end

        trait :admin do
            role { :admin }
        end
    end
end