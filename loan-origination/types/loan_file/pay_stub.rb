module FoobaraDemo
  module LoanOrigination
    class LoanFile < Foobara::Entity
      class PayStub < Foobara::Model
        attributes do
          amount :integer, :required, "Amount in dollars of the pay check"
          date :date, :required, "Date the paycheck was issued"
          employer :string, :required, "Name of the employer that issued this paycheck"
        end
      end
    end
  end
end
