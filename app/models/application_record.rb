class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  class << self
    def find_by_param!(param)
      find_by!(id: param)
    end
  end
end


