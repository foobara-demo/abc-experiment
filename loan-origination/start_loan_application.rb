module FoobaraDemo
  module LoanOrigination
    class StartLoanApplication < Foobara::Command
      inputs do
        applicant LoanFile::Applicant.attributes_type
        credit_policy CreditPolicy
      end
      result LoanFile

      def execute
        create_application
        create_loan_file

        loan_file
      end

      attr_accessor :loan_file, :loan_application

      def create_application
        self.loan_application = LoanFile::LoanApplication.new(applicant:)
      end

      def create_loan_file
        self.loan_file = LoanFile.create(loan_application:, credit_policy:)
      end
    end
  end
end
