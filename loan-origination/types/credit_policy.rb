module FoobaraDemo
  module LoanOrigination
    class CreditPolicy < Foobara::Entity
      attributes do
        id :integer
        institution :string, :required
        minimum_pay_stub_count :integer, :required,
                               "The loan file must have at least this many pay stubs."
        minimum_credit_score :integer, :required
        credit_score_to_use :symbol,
                            :required,
                            one_of: [:median, :maximum],
                            description: "If the scores are 500, 650, and 700, then " \
                                         "maximum will compare the biggest (700) against minimum_credit_score " \
                                         "and median will compare the median (650) against minimum_credit_score."
      end

      primary_key :id
    end
  end
end
