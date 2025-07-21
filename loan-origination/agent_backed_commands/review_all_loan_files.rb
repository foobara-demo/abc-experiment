module FoobaraDemo
  module LoanOrigination
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
