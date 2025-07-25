module FoobaraDemo
  module LoanOrigination
    class ReviewAllLoanFiles < Foobara::Command
      description "Reviews all loan files that need review until no more that need review are found."

      result :array do
        applicant_name :string, :required
        decision LoanFile::UnderwriterDecision, :required
      end

      depends_on ReviewLoanFile, FindALoanFileThatNeedsReview
      depends_on_entity LoanFile

      def execute
        each_loan_file_that_needs_review do
          review_loan_file
        end

        results
      end

      attr_accessor :loan_file

      def each_loan_file_that_needs_review
        loop do
          self.loan_file = run_subcommand!(FindALoanFileThatNeedsReview)
          break unless loan_file

          yield
        end
      end

      def review_loan_file
        results << {
          applicant_name: loan_file.loan_application.applicant.name,
          decision: run_subcommand!(ReviewLoanFile, loan_file:)
        }
      end

      def results
        @results ||= []
      end
    end
  end
end
