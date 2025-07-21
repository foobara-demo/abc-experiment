module FoobaraDemo
  module LoanOrigination
    module Demo
      class PrepareDemoRecords < Foobara::Command
        result [LoanFile]

        depends_on CreateCreditPolicy,
                   StartLoanApplication,
                   AddCreditScore,
                   AddPayStub,
                   SubmitApplicationForUnderwriterReview

        def execute
          delete_all_loan_files
          delete_all_credit_policies

          create_credit_policy_that_requires_better_fico_scores
          create_credit_policy_that_requires_more_income_verification
          create_lenient_credit_policy

          create_demo_loan_files

          each_loan_file do
            create_pay_stubs
            create_credit_scores
            submit_application_for_underwriter_review
          end

          demo_loan_files
        end

        attr_accessor :credit_policy_that_requires_better_fico_scores,
                      :credit_policy_that_requires_more_income_verification,
                      :lenient_credit_policy,
                      :demo_loan_files,
                      :loan_file

        def delete_all_loan_files
          LoanFile.all.each(&:hard_delete!)
        end

        def delete_all_credit_policies
          CreditPolicy.all.each(&:hard_delete!)
        end

        def create_credit_policy_that_requires_better_fico_scores
          self.credit_policy_that_requires_better_fico_scores = run_subcommand!(
            CreateCreditPolicy, institution: "Bank A",
                                minimum_credit_score: 700,
                                credit_score_to_use: :median,
                                minimum_pay_stub_count: 1
          )
        end

        def create_credit_policy_that_requires_more_income_verification
          self.credit_policy_that_requires_more_income_verification = run_subcommand!(
            CreateCreditPolicy, institution: "Bank B",
                                minimum_credit_score: 700,
                                credit_score_to_use: :maximum,
                                minimum_pay_stub_count: 2
          )
        end

        def create_lenient_credit_policy
          self.lenient_credit_policy = run_subcommand!(
            CreateCreditPolicy, institution: "Bank C",
                                minimum_credit_score: 700,
                                credit_score_to_use: :maximum,
                                minimum_pay_stub_count: 1
          )
        end

        def create_demo_loan_files
          name_to_credit_policy = {
            Barbara: credit_policy_that_requires_better_fico_scores,
            Basil: credit_policy_that_requires_more_income_verification,
            Fumiko: lenient_credit_policy
          }

          self.demo_loan_files = name_to_credit_policy.map do |name, credit_policy|
            run_subcommand!(StartLoanApplication, applicant: { name: }, credit_policy:)
          end
        end

        def each_loan_file
          demo_loan_files.each do |loan_file|
            self.loan_file = loan_file
            yield
          end
        end

        def create_credit_scores
          {
            experian: 600,
            equifax: 650,
            transunion: 750
          }.each_pair do |reporting_agency, score|
            run_subcommand!(AddCreditScore, loan_file:, credit_score: { reporting_agency:, score: })
          end
        end

        def create_pay_stubs
          run_subcommand!(AddPayStub, loan_file:,
                                      pay_stub: {
                                        amount: 3000,
                                        date: "2025-06-25",
                                        employer: "Some Employer"
                                      })
        end

        def submit_application_for_underwriter_review
          run_subcommand!(SubmitApplicationForUnderwriterReview, loan_file:)
        end
      end
    end
  end
end
