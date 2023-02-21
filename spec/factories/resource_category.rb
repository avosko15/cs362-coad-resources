# factory implementation - 4.0

FactoryBot.define do
    factory :resource_category do
        # name { "Snow" }
        sequence :name do |n|
            "Snow#{n}"
        end
    end
end