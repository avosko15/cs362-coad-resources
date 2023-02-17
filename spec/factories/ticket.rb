# factory implementation - 4.0

FactoryBot.define do
    factory :ticket do
        
        trait :req_fields_ticket do
            name { 'Sample ticket user name' }
            phone { '+1 555-555-5555' }
            region_id { create(:region).id }
            resource_category_id { create(:resource_category).id }
        end

    end
end
