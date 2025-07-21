module FoobaraDemo
  module LoanOrigination
    class StartUnderwriterReview < Foobara::AgentBackedCommand
      description "Starts the review by moving the loan file from needs_review to in_review"

      inputs do
        loan_file LoanFile, :required
      end
    end

    class ApproveLoanFile < Foobara::AgentBackedCommand
      depends_on CreateUnderwriterDecision, TransitionLoanFileState

      inputs do
        credit_score_used :integer, :required
        loan_file LoanFile, :required
      end
    end

    class DenyLoanFile < Foobara::AgentBackedCommand
      depends_on CreateUnderwriterDecision, TransitionLoanFileState

      possible_input_error :denied_reasons, :cannot_be_empty

      inputs do
        credit_score_used :integer, :required
        denied_reasons [:denied_reason], :required
        loan_file LoanFile, :required
      end
    end

    class UnderwriterSummary < Foobara::Model
      attributes do
        loan_file_id :integer, :required
        pay_stub_count :integer, :required
        fico_scores [:integer, :integer, :integer], :required
        credit_policy CreditPolicy, :required
      end
    end

    class ReviewLoanFile < Foobara::AgentBackedCommand
      description "Starts the underwriter review then checks requirements in its CreditPolicy " \
                    "and approves or denies accordingly."

      inputs UnderwriterSummary
      result LoanFile::UnderwriterDecision

      depends_on StartUnderwriterReview, DenyLoanFile, ApproveLoanFile
    end

    class ReviewAllLoanFiles < Foobara::AgentBackedCommand
      description "Reviews all loan files that need review until no more that need review are found."

      result [{
                applicant_name: :string,
                decision: LoanFile::UnderwriterDecision
              }]

      depends_on ReviewLoanFile, FindALoanFileThatNeedsReview
    end
  end
end
