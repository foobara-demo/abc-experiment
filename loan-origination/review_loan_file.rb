module FoobaraDemo
  module LoanOrigination
    class UnderwriterSummary < Foobara::Model
      attributes do
        loan_file_id :integer, :required
        pay_stub_count :integer, :required
        fico_scores [:integer, :integer, :integer], :required
        credit_policy CreditPolicy, :required
      end
    end

    class ReviewLoanFile < Foobara::Command
      description "Starts the underwriter review then checks requirements in its CreditPolicy " \
                  "and approves or denies accordingly."

      inputs UnderwriterSummary
      result LoanFile::UnderwriterDecision

      depends_on StartUnderwriterReview, DenyLoanFile, ApproveLoanFile

      def execute
        start_underwriter_review
        determine_which_credit_score_to_use
        check_fico_score
        check_income_verification_requirements

        if any_denied_reasons?
          deny_loan_file
        else
          approve_loan_file
        end

        underwriter_decision
      end

      attr_accessor :credit_score_used, :underwriter_decision

      def start_underwriter_review
        run_subcommand!(StartUnderwriterReview, loan_file: loan_file_id)
      end

      def determine_which_credit_score_to_use
        self.credit_score_used = case credit_policy.credit_score_to_use
                                 when :median
                                   fico_scores.sort[1]
                                 when :maximum
                                   fico_scores.max
                                 else
                                   raise "Unknown credit_score_to_use: #{credit_policy.credit_score_to_use}"
                                 end
      end

      def check_fico_score
        if credit_score_used < credit_policy.minimum_credit_score
          denied_reasons << DeniedReason::LOW_CREDIT_SCORE
        end
      end

      def check_income_verification_requirements
        if pay_stub_count < credit_policy.minimum_pay_stub_count
          denied_reasons << DeniedReason::INSUFFICIENT_PAY_STUBS_PROVIDED
        end
      end

      def denied_reasons
        @denied_reasons ||= []
      end

      def any_denied_reasons?
        denied_reasons.any?
      end

      def approve_loan_file
        self.underwriter_decision = run_subcommand!(ApproveLoanFile,
                                                    loan_file: loan_file_id,
                                                    credit_score_used:)
      end

      def deny_loan_file
        self.underwriter_decision = run_subcommand!(DenyLoanFile,
                                                    loan_file: loan_file_id,
                                                    denied_reasons:,
                                                    credit_score_used:)
      end
    end
  end
end
