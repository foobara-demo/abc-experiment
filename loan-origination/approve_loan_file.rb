module FoobaraDemo
  module LoanOrigination
    class ApproveLoanFile < Foobara::Command
      description "Creates an approved underwriter decision for the loan file and transitions to drafting_docs"

      depends_on CreateUnderwriterDecision, TransitionLoanFileState

      inputs do
        credit_score_used :integer, :required
        loan_file LoanFile, :required
      end

      result LoanFile::UnderwriterDecision

      def execute
        create_underwriting_decision
        transition_loan_file

        underwriter_decision
      end

      attr_accessor :underwriter_decision

      def transition
        :approve
      end

      def create_underwriting_decision
        self.underwriter_decision = run_subcommand!(
          CreateUnderwriterDecision,
          loan_file:,
          decision: :approved,
          credit_score_used:
        )
      end

      def transition_loan_file
        run_subcommand!(TransitionLoanFileState, loan_file:, transition:)
      end
    end
  end
end
