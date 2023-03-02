# factory implementation - 4.0

FactoryBot.define do
    factory :organization do
      # email { 'fake_organization_email@gmail.com' }
      sequence(:email) { |n| "fake_organization_email#{n}@gmail.com" }
      # name { 'Fake Organization Name' }
      sequence(:name) { |n|"Fake Organization #{n}" }
      phone { '555-555-5555' }
      status { :submitted }
      primary_name { 'Organization Primary Name' }
      secondary_name { 'Organization Secondary Name' }
      secondary_phone { '444-444-4444' }
  
      trait :approved do
        status { :approved }
      end
  
      trait :rejected do
        status { :rejected }
      end
    end
  end
  