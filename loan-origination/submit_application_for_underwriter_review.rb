module FoobaraDemo
  module LoanOrigination
    class SubmitApplicationForUnderwriterReview < Foobara::Command
      inputs do
        loan_file LoanFile, :required
      end
      result LoanFile

      def execute
        transition_loan_file

        loan_file
      end

      def transition_loan_file
        loan_file.state_machine.perform_transition!(:loan_file_complete)
      end
    end
  end
end
