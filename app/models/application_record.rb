class ApplicationRecord < ActiveRecord::Base
  include ModelError
  
  self.abstract_class = true
  
end
