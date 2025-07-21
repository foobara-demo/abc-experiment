module FoobaraDemo
  module LoanOrigination
    class AddPayStub < Foobara::Command
      description "Add a pay stub to a loan file"

      inputs do
        loan_file LoanFile, :required, "Which loan file to add this pay stub to"
        pay_stub LoanFile::PayStub, :required
      end
      result LoanFile

      def execute
        add_pay_stub_to_loan_file
        loan_file
      end

      def add_pay_stub_to_loan_file
        loan_file.pay_stubs += [pay_stub]
      end
    end
  end
end
