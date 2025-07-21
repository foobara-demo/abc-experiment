module FoobaraDemo
  module LoanOrigination
    class CannotTransitionStateError < Foobara::DataError
      context do
        loan_file_id :integer, :required
        current_state :string, :required, one_of: LoanFile::StateMachine.states
        required_states :array, :required,
                        element_type_declaration: {
                          type: :string,
                          one_of: LoanFile::StateMachine.states
                        }
        attempted_transition :string, :required, one_of: LoanFile::StateMachine.transitions
      end

      attr_accessor :loan_file, :attempted_transition

      def initialize(loan_file, attempted_transition:, **)
        self.loan_file = loan_file
        self.attempted_transition = attempted_transition

        super(**)
      end

      def context
        {
          loan_file_id: loan_file.id,
          current_state: loan_file.state,
          required_states:,
          attempted_transition:
        }
      end

      def required_states
        LoanFile::StateMachine.states_that_can_perform(attempted_transition)
      end

      def message
        "Cannot perform #{attempted_transition} transition for loan file #{loan_file.id} from #{loan_file.state}. " \
          "Expected state to be one of: #{required_states}. Did you forget to start the review?"
      end
    end
  end
end
