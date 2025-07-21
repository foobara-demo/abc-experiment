module FoobaraDemo
  module LoanOrigination
    class ReportRow < Foobara::Model
      attributes do
        id :integer, :required, "The loan file id"
        applicant :string, :required, "The name of the applicant"
        state :string, :required, "The state of the loan file"
        underwriter_decision LoanFile::UnderwriterDecision, "Denied reasons omitted if approved"
      end
    end

    class GenerateLoanFilesReport < Foobara::Command
      result [ReportRow]

      depends_on FindAllLoanFiles

      def execute
        load_all_loan_files
        generate_report

        report
      end

      attr_accessor :loan_files, :report

      def load_all_loan_files
        self.loan_files = run_subcommand!(FindAllLoanFiles)
      end

      def generate_report
        self.report = loan_files.map do |loan_file|
          underwriter_decision = loan_file.underwriter_decision

          report = {
            id: loan_file.id,
            applicant: loan_file.loan_application.applicant.name,
            state: loan_file.state
          }

          if underwriter_decision
            attributes = {
              decision: underwriter_decision.decision,
              credit_score_used: underwriter_decision.credit_score_used
            }

            denied_reasons = underwriter_decision.denied_reasons

            if denied_reasons && !denied_reasons.empty?
              attributes[:denied_reasons] = denied_reasons
            end

            report[:underwriter_decision] = attributes
          end

          report
        end
      end
    end
  end
end
