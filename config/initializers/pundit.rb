module Pundit
  module ProperReturns
    def authorize(record, *)
      super
      record
    end
  end
  prepend ProperReturns

  class PolicyFinder
    module PolicyDefault
      def policy
        super || ApplicationPolicy
      end
    end
    prepend PolicyDefault
  end
end

