module FoobaraDemo
  module LoanOrigination
    class DenyLoanFile < Foobara::AgentBackedCommand
      depends_on CreateUnderwriterDecision, TransitionLoanFileState

      possible_input_error :denied_reasons, :cannot_be_empty

      inputs do
        credit_score_used :integer, :required
        denied_reasons [:denied_reason], :required
        loan_file LoanFile, :required
      end

      result LoanFile::UnderwriterDecision
    end
  end
end
