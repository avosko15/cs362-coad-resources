Rails.application.secrets.admins.each do |key, value|
  unless User.exists?(email: value.downcase)
    puts "Seeding #{key}"
    user = User.new(
      email: value,
      password: Rails.application.secrets[:default_admin_password],
      role: 0
    )
    user.skip_confirmation!
    user.save!
  end
end

puts "Seeding regions"
regions = ["Bend", "Sisters", "La Pine", "Redmond"]
regions.each do |region|
  Region.create(name: region) unless Region.exists?(name: region)
end

puts "Seeding resource categories"
resource_categories = ["General", "Snow Removal", "Medical", "Water", "Home Repair", "Pest Control", "Animal Rescue"]
resource_categories.each do |resource_category|
  ResourceCategory.create(name: resource_category) unless ResourceCategory.exists?(name: resource_category)
end

puts "Seeding pending organizations"
if Rails.env == 'development'
  pending_organizations = ["REACT International", "DirectRelief"]
  pending_organizations.each do |pending_organization|
    unless Organization.exists?(email: "#{pending_organization.split(" ").join(".")}@testing.com")
      Organization.create(
        name: pending_organization,
        email: "#{pending_organization.split(" ").join(".")}@testing.com",
        phone: "541-398-3298",
        liability_insurance: true,
        primary_name: 'Primary Name',
        secondary_name: 'Secondary Name',
        secondary_phone: '555-555-5555',
        title: 'Title',
        transportation: :yes,
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore
                      et dolore magna aliqua. Quam adipiscing vitae proin sagittis nisl rhoncus. Nunc faucibus a pellentesque
                      sit amet porttitor eget dolor morbi. Eu non diam phasellus vestibulum lorem sed risus ultricies tristique.
                      Eu facilisis sed odio morbi quis commodo odio aenean sed. Aliquam purus sit amet luctus venenatis lectus magna.",
        status: 1
      )
    end
  end

  puts "Seeding approved organizations"
  approved_organizations = ["Red Cross", "OXFAM", "Doctors Without Borders"]
  approved_organizations.each do |approved_organization|
    unless Organization.exists?(email: "#{approved_organization.split(" ").join(".")}}@testing.com")
      Organization.create(
        name: approved_organization,
        email: "#{approved_organization.split(" ").join(".")}@testing.com",
        phone: "541-398-3298",
        liability_insurance: true,
        primary_name: 'Primary Name',
        secondary_name: 'Secondary Name',
        secondary_phone: '555-555-5555',
        title: 'Title',
        transportation: :yes,
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore
                      et dolore magna aliqua. Quam adipiscing vitae proin sagittis nisl rhoncus. Nunc faucibus a pellentesque
                      sit amet porttitor eget dolor morbi. Eu non diam phasellus vestibulum lorem sed risus ultricies tristique.
                      Eu facilisis sed odio morbi quis commodo odio aenean sed. Aliquam purus sit amet luctus venenatis lectus magna.",
        status: 0
      )
    end
  end

  puts "Seeding help tickets"
  open_ticket_names = ['John Smith', 'Robert Brown', 'Richard Davis', 'Charles Wilson']
  closed_ticket_names = ['Thomas Moore', 'Steven Harris']

  open_ticket_names.each do |open_ticket_name|
    unless Ticket.exists?(name: open_ticket_name)
      ticket = Ticket.create(
        name: open_ticket_name,
        phone: '+15414541232',
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore
                      et dolore magna aliqua. Quam adipiscing vitae proin sagittis nisl rhoncus. Nunc faucibus a pellentesque
                      sit amet porttitor eget dolor morbi. Eu non diam phasellus vestibulum lorem sed risus ultricies tristique.
                      Eu facilisis sed odio morbi quis commodo odio aenean sed. Aliquam purus sit amet luctus venenatis lectus magna.",
        region_id: Region.all[Random.rand(Region.all.length - 1)].id,
        resource_category_id: ResourceCategory.all[Random.rand(ResourceCategory.all.length - 1)].id,
        closed: false
      )
    end
  end

  closed_ticket_names.each do |closed_ticket_name|
    unless Ticket.exists?(name: closed_ticket_name)
      ticket = Ticket.create(
        name: closed_ticket_name,
        phone: '+15414541232',
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore
                      et dolore magna aliqua. Quam adipiscing vitae proin sagittis nisl rhoncus. Nunc faucibus a pellentesque
                      sit amet porttitor eget dolor morbi. Eu non diam phasellus vestibulum lorem sed risus ultricies tristique.
                      Eu facilisis sed odio morbi quis commodo odio aenean sed. Aliquam purus sit amet luctus venenatis lectus magna.",
        region_id: Region.all[Random.rand(Region.all.length - 1)].id,
        resource_category_id: ResourceCategory.all[Random.rand(ResourceCategory.all.length - 1)].id,
        closed: true
      )
    end
  end

  unless Organization.exists?(email: Rails.application.secrets.user[:email].downcase)
    Organization.create(
      name: 'test organization',
      email: Rails.application.secrets.user[:email],
      phone: 'XXX-XXX-XXXX',
      liability_insurance: true,
      primary_name: 'Primary Name',
      secondary_name: 'Secondary Name',
      secondary_phone: '555-555-5555',
      title: 'Title',
      transportation: :yes,
      description: 'best test',
      status: 0
    )
  end

  unless User.exists?(email: Rails.application.secrets.user[:email].downcase)
    test_user = User.new(
      email: Rails.application.secrets.user[:email],
      password: Rails.application.secrets.user[:password],
      organization_id: Organization.find_by(email: Rails.application.secrets.user[:email]).id,
      role: 1
    )
    test_user.skip_confirmation!
    test_user.save!
  end

  unless ResourceCategory.exists?(name: 'test')
    ResourceCategory.create(name: 'test')
  end
end
