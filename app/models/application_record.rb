# Defines the parent class of all parts of an application (organization, region, category, ticket, user).
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
