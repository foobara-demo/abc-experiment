module FoobaraDemo
  module LoanOrigination
    class AddCreditScore < Foobara::Command
      inputs do
        loan_file LoanFile, :required
        credit_score LoanFile::CreditScore, :required
      end
      result LoanFile

      def execute
        add_credit_score_to_loan_file
        loan_file
      end

      def add_credit_score_to_loan_file
        loan_file.credit_scores += [credit_score]
      end
    end
  end
end
