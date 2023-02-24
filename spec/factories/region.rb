# factory implementation - 4.0

FactoryBot.define do
    factory :region do
        # name { "Sisters" }
        sequence :name do |n|
            "Sisters#{n}"
        end
        
        trait :updatable_region do
            name { :organization }
            organization_id { create(:organization, :approved).id }
        end
    end
end