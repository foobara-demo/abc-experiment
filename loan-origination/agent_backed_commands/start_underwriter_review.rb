module FoobaraDemo
  module LoanOrigination
    class StartUnderwriterReview < Foobara::AgentBackedCommand
      description "Starts the review by moving the loan file from needs_review to in_review"

      inputs do
        loan_file LoanFile, :required
      end
    end
  end
end
