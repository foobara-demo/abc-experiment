module FoobaraDemo
  module LoanOrigination
    class StartUnderwriterReview < Foobara::Command
      inputs do
        loan_file LoanFile, :required
      end

      def execute
        transition_loan_file

        nil
      end

      def transition_loan_file
        loan_file.state_machine.perform_transition!(:start_review)
      end
    end
  end
end
