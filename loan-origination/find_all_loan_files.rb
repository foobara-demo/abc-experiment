module FoobaraDemo
  module LoanOrigination
    class FindAllLoanFiles < Foobara::Command
      result [LoanFile]

      def execute
        load_all_loan_files

        loan_files
      end

      attr_accessor :loan_files

      def load_all_loan_files
        self.loan_files = LoanFile.all
      end
    end
  end
end
