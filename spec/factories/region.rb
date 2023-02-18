# factory implementation - 4.0

FactoryBot.define do
    factory :region do
        # name { "Sisters" }
        sequence :name do |n|
            "Sisters#{n}"
        end
    end
end