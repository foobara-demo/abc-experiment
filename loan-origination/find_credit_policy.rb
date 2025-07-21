module FoobaraDemo
  module LoanOrigination
    class FindCreditPolicy < Foobara::Command
      inputs do
        credit_policy CreditPolicy, :required
      end
      result CreditPolicy

      load_all

      def execute
        credit_policy
      end
    end
  end
end
