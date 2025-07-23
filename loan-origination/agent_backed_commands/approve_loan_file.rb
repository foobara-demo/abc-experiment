module FoobaraDemo
  module LoanOrigination
    class ApproveLoanFile < Foobara::AgentBackedCommand
      description "Creates an approved underwriter decision for the loan file and transitions to drafting_docs"

      depends_on CreateUnderwriterDecision, TransitionLoanFileState

      inputs do
        credit_score_used :integer, :required
        loan_file LoanFile, :required
      end

      result LoanFile::UnderwriterDecision
    end
  end
end
