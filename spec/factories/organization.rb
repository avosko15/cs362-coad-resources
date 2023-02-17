# factory implementation - 4.0

FactoryBot.define do
    factory :organization do

        trait :req_fields_organization do
            email { 'fake_organization_email@gmail.com' }
            name { 'Fake Organization Name' }
            phone { '555-555-5555' }
            # status { :submitted } - I think this is default?
            primary_name { 'Organization Primary Name' }
            secondary_name { 'Organization Secondary Name' }
            secondary_phone { '444-444-4444' }
        end

    end
end