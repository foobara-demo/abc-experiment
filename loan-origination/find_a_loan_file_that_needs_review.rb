require_relative "find_loan_file_by"

module FoobaraDemo
  module LoanOrigination
    class FindALoanFileThatNeedsReview < Foobara::Command
      description "Will return a loan file in needs_review state or nil if there are none"

      result LoanFile, :allow_nil

      depends_on FindLoanFileBy

      def execute
        find_loan_file_that_needs_review
        loan_file
      end

      attr_accessor :loan_file

      def find_loan_file_that_needs_review
        self.loan_file = run_subcommand!(FindLoanFileBy, state: "needs_review")
      end
    end
  end
end
