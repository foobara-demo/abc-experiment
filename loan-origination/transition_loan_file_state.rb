module FoobaraDemo
  module LoanOrigination
    class TransitionLoanFileState < Foobara::Command
      possible_input_error :loan_file, CannotTransitionStateError

      inputs do
        loan_file LoanFile, :required
        transition :symbol, :required, one_of: LoanFile::StateMachine.transitions
      end

      result LoanFile

      def execute
        perform_transition
        loan_file
      end

      def validate
        unless loan_file.state_machine.can?(transition)
          add_input_error CannotTransitionStateError.new(loan_file, attempted_transition: transition, path: :loan_file)
        end
      end

      private

      def perform_transition
        loan_file.state_machine.perform_transition!(transition)
      end
    end
  end
end
