# factory implementation - 4.0

FactoryBot.define do
    factory :user do
        email { 'bario54321@gmail.com' }
        password { "fake_password" }

        before(:create) { |user| user.skip_confirmation! }

        trait :organization_approved do
            role { :organization }
            organization_id { create(:organization, :approved).id }
        end

        trait :organization_unapproved do
            role { :organization }
            organization_id { create(:organization).id }
        end
    end
end