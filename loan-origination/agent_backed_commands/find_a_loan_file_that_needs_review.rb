module FoobaraDemo
  module LoanOrigination
    class FindALoanFileThatNeedsReview < Foobara::AgentBackedCommand
      description "Will return a loan file in needs_review state or nil if there are none"

      result LoanFile, :allow_nil

      depends_on FindLoanFileBy
    end
  end
end
