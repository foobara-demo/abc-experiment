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
  end
end
