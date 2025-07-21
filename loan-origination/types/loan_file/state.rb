module FoobaraDemo
  module LoanOrigination
    class LoanFile < Foobara::Entity
      State = Foobara::Enumerated.make_module(LoanFile::StateMachine.states)
    end

    foobara_register_type(:state, :symbol, one_of: LoanFile::State)
  end
end
