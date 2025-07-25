module FoobaraDemo
  module LoanOrigination
    class ReviewAllLoanFiles < Foobara::AgentBackedCommand
      description "Reviews all loan files that need review until no more that need review are found."

      result :array do
        applicant_name :string, :required
        decision LoanFile::UnderwriterDecision, :required
      end

      depends_on ReviewLoanFile, FindALoanFileThatNeedsReview
    end
  end
end
