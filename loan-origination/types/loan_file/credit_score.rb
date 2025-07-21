module FoobaraDemo
  module LoanOrigination
    class LoanFile < Foobara::Entity
      class CreditScore < Foobara::Model
        attributes do
          score :integer
          reporting_agency :string, one_of: [:equifax, :experian, :transunion]
        end
      end
    end
  end
end
