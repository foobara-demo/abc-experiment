module FoobaraDemo
  module LoanOrigination
    class ReviewAllLoanFiles < Foobara::Command
      description "Reviews all loan files that need review until no more that need review are found."

      result [{
        applicant_name: :string,
        decision: LoanFile::UnderwriterDecision
      }]

      depends_on ReviewLoanFile, FindALoanFileThatNeedsReview

      def execute
        each_loan_file_that_needs_review do
          review_loan_file
        end

        results
      end

      attr_accessor :loan_file

      def each_loan_file_that_needs_review
        loop do
          self.loan_file = find_a_loan_file_that_needs_review
          break unless loan_file

          yield
        end
      end

      def review_loan_file
        outcome = run_subcommand!(ReviewLoanFile,
                                  loan_file_id: loan_file.id,
                                  pay_stub_count: loan_file.pay_stubs.size,
                                  fico_scores: loan_file.credit_scores.map(&:score),
                                  credit_policy: loan_file.credit_policy)

        applicant_name = loan_file.loan_application.applicant.name

        results << if outcome.success?
                     underwriter_decision = outcome.result

                     result = { applicant_name:, decision: underwriter_decision.decision }

                     if underwriter_decision.denied?
                       result[:denied_reasons] = underwriter_decision.denied_reasons
                     end

                     result
                   else
                     { applicant_name:, decision: nil }
                   end
      end

      def results
        @results ||= []
      end
    end
  end
end
