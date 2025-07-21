module FoobaraDemo
  module LoanOrigination
    class CreateCreditPolicy < Foobara::Command
      inputs CreditPolicy.attributes_for_create
      result CreditPolicy

      def execute
        create_credit_policy

        credit_policy
      end

      attr_accessor :credit_policy

      def create_credit_policy
        self.credit_policy = CreditPolicy.create(inputs)
      end
    end
  end
end
