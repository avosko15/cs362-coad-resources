# Overarching class for all aspects of an application
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
