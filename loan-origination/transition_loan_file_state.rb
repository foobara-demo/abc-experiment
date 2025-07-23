module FoobaraDemo
  module LoanOrigination
    class TransitionLoanFileState < Foobara::Command
      possible_input_error :loan_file, CannotTransitionStateError

      inputs do
        loan_file LoanFile, :required
        transition :symbol, :required, one_of: LoanFile::StateMachine.transitions
      end

      result type: :state, description: "new LoanFile state"

      def execute
        perform_transition

        loan_file_state
      end

      def validate
        if [:deny, :approve].include?(transition)
          unless loan_file.state_machine.can?(transition)
            add_input_error CannotTransitionStateError.new(
              loan_file,
              attempted_transition: transition,
              path: :loan_file
            )
            return
          end

          if loan_file.underwriter_decision.nil?
            add_input_error CannotTransitionStateError.new(
              loan_file,
              attempted_transition: transition,
              path: :loan_file,
              message: "Cannot perform #{transition} transition that has no underwriter_decision."
            )
          end
        end
      end

      def perform_transition
        loan_file.state_machine.perform_transition!(transition)
      end

      def loan_file_state
        loan_file.state
      end
    end
  end
end
