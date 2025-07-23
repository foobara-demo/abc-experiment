env = ENV["FOOBARA_ENV"] ||= "development"

ENV["BUNDLE_GEMFILE"] ||= File.expand_path("./Gemfile", __dir__)
require "bundler/setup"

require "pry"
require "pry-byebug"

require "dotenv"
require "foobara/load_dotenv"
Foobara::LoadDotenv.run!(env:, dir: __dir__)

require "foobara/anthropic_api" if ENV.key?("ANTHROPIC_API_KEY")
require "foobara/open_ai_api" if ENV.key?("OPENAI_API_KEY")
require "foobara/ollama_api" if ENV.key?("OLLAMA_API_URL")

require "foobara/local_files_crud_driver"
crud_driver = Foobara::LocalFilesCrudDriver.new(multi_process: true, data_path: "#{__dir__}/local_data/records.yml")
Foobara::Persistence.default_crud_driver = crud_driver

require "foobara/agent_backed_command"

require_relative "loan_origination"
Foobara::Util.require_directory("#{__dir__}/loan-origination/types")

require_relative "loan-origination/add_credit_score"
require_relative "loan-origination/add_pay_stub"
require_relative "loan-origination/create_credit_policy"
require_relative "loan-origination/create_underwriter_decision"
require_relative "loan-origination/find_all_loan_files"
require_relative "loan-origination/find_credit_policy"
require_relative "loan-origination/find_loan_file"
require_relative "loan-origination/find_loan_file_by"
require_relative "loan-origination/start_loan_application"
require_relative "loan-origination/submit_application_for_underwriter_review"
require_relative "loan-origination/transition_loan_file_state"
