module FoobaraDemo
  module LoanOrigination
    class FindLoanFileBy < Foobara::Command
      inputs LoanFile.attributes_for_find_by
      result LoanFile, :allow_nil

      def execute
        find_loan_file

        loan_file
      end

      attr_accessor :loan_file

      def find_loan_file
        self.loan_file = LoanFile.find_by(inputs)
      end
    end
  end
end
