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

    class ReviewLoanFile < Foobara::AgentBackedCommand
      description "Starts the underwriter review then checks requirements in its CreditPolicy " \
                    "and approves or denies accordingly."

      inputs UnderwriterSummary
      result LoanFile::UnderwriterDecision

      depends_on StartUnderwriterReview, DenyLoanFile, ApproveLoanFile
    end
  end
end
