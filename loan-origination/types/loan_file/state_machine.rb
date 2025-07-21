module FoobaraDemo
  module LoanOrigination
    class LoanFile < Foobara::Entity
      StateMachine = Foobara::StateMachine.for(
        building_loan_file: {
          loan_file_complete: :needs_review
        },
        needs_review: {
          start_review: :in_review
        },
        in_review: {
          deny: :denied,
          approve: :drafting_docs
        },
        drafting_docs: {
          sign: :in_escrow
        },
        in_escrow: {
          record: :recorded
        }
      )
    end
  end
end
