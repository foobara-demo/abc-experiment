module FoobaraDemo
  module LoanOrigination
    class ReviewLoanFile < Foobara::AgentBackedCommand
      description "Starts the underwriter review then checks requirements in its CreditPolicy " \
                  "and approves or denies accordingly."

      inputs do
        loan_file LoanFile, :required
      end
      result LoanFile::UnderwriterDecision

      depends_on StartUnderwriterReview, DenyLoanFile, ApproveLoanFile
    end
  end
end
