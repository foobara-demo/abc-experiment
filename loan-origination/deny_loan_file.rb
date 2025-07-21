module FoobaraDemo
  module LoanOrigination
    class DenyLoanFile < Foobara::Command
      depends_on CreateUnderwriterDecision, TransitionLoanFileState

      possible_input_error :denied_reasons, :cannot_be_empty

      inputs do
        credit_score_used :integer, :required
        denied_reasons [:denied_reason], :required
        loan_file LoanFile, :required
      end

      result LoanFile::UnderwriterDecision

      def execute
        create_underwriting_decision
        transition_loan_file

        underwriter_decision
      end

      attr_accessor :underwriter_decision

      def validate
        if denied_reasons.empty?
          add_input_error(:denied_reasons, :cannot_be_empty)
        end
      end

      def create_underwriting_decision
        self.underwriter_decision = run_subcommand!(
          CreateUnderwriterDecision,
          loan_file:,
          decision: :denied,
          credit_score_used:,
          denied_reasons:
        )
      end

      def transition
        :deny
      end

      def transition_loan_file
        run_subcommand!(TransitionLoanFileState, loan_file:, transition:)
      end
    end
  end
end
