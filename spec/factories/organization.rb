# factory implementation - 4.0

FactoryBot.define do
    factory :organization do
        # name {'Fake name'}
        # status {:submitted}
        # phone {'541-999-9999'}
        # email {'fakeemail@gmail.com'}
        # description {'Fake description'}
        # rejection_reason {'Fake rejection reason'}
        # liability_insurance {'Fake liability insurance'}
        # primary_name {'Fake primary name'}
        # secondary_name {'Fake secondary name'}
        # secondary_phone {'541-888-8888'}
        # title {'Fake title'}
        # transportation {:maybe}

        trait :req_fields_organization do
            email
            name
            phone
            status
            
        end
    end
end


# trait :organization_approved_user do
#     role { :organization }
#     organization_id { create(:organization, :approved).id }
# end