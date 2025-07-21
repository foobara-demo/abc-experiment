require_relative "errors/cannot_transition_state_error"

module FoobaraDemo
  module LoanOrigination
    class CreateUnderwriterDecision < Foobara::Command
      inputs do
        loan_file LoanFile, :required
        decision :decision, :required
        credit_score_used :integer, :required
        denied_reasons [:denied_reason], default: []
      end

      result LoanFile::UnderwriterDecision

      def execute
        create_underwriter_decision
        attach_decision_to_loan_file
        underwriter_decision
      end

      private

      attr_accessor :underwriter_decision

      def create_underwriter_decision
        self.underwriter_decision = LoanFile::UnderwriterDecision.new(
          decision:,
          credit_score_used:,
          denied_reasons:
        )
      end

      def attach_decision_to_loan_file
        loan_file.underwriter_decision = underwriter_decision
      end
    end
  end
end
