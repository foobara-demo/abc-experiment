require_relative "applicant"

module FoobaraDemo
  module LoanOrigination
    class LoanFile < Foobara::Entity
      class LoanApplication < Foobara::Model
        attributes do
          applicant Applicant, :required
        end
      end
    end
  end
end
