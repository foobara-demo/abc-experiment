module FoobaraDemo
  module LoanOrigination
    class LoanFile < Foobara::Entity
      class Applicant < Foobara::Model
        attributes do
          name :string, :required
        end
      end
    end
  end
end
