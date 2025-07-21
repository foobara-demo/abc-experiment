module FoobaraDemo
  module LoanOrigination
    module Decision
      APPROVED = :approved
      DENIED = :denied
    end

    module DeniedReason
      INSUFFICIENT_PAY_STUBS_PROVIDED = :insufficient_pay_stubs_provided
      LOW_CREDIT_SCORE = :low_credit_score
    end

    foobara_register_type(:decision, :symbol, one_of: Decision)
    foobara_register_type(:denied_reason, :symbol, one_of: DeniedReason)

    class LoanFile < Foobara::Entity
      class UnderwriterDecision < Foobara::Model
        attributes do
          decision :decision, :required
          credit_score_used :integer, :required
          denied_reasons [:denied_reason], default: []
        end

        def denied?
          decision == Decision::DENIED
        end
      end
    end
  end
end
