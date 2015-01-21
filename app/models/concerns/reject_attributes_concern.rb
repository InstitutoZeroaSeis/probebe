module RejectAttributesConcern
  extend ActiveSupport::Concern

  module ClassMethods
    def all_blank?(*attributes)
      proc do |hash = {}|
        attributes.all? do |attr|
          hash[attr].blank?
        end
      end
    end
  end

end
