env = ENV["FOOBARA_ENV"] ||= "development"

ENV["BUNDLE_GEMFILE"] ||= File.expand_path("./Gemfile", __dir__)
require "bundler/setup"

# require "pry"
# require "pry-byebug"

require "dotenv"
require "foobara/load_dotenv"
Foobara::LoadDotenv.run!(env:, dir: __dir__)

# require "foobara/ai"
require "foobara/anthropic_api" if ENV.key?("ANTHROPIC_API_KEY")
# require "foobara/open_ai_api" if ENV.key?("OPENAI_API_KEY")
require "foobara/ollama_api" if ENV.key?("OLLAMA_API_URL")

require "foobara/local_files_crud_driver"
crud_driver = Foobara::LocalFilesCrudDriver.new(multi_process: true, data_path: "#{__dir__}/local_data/records.yml")
Foobara::Persistence.default_crud_driver = crud_driver

require "foobara_demo/loan_origination"
require "foobara/agent_backed_command"
require_relative "moar_loan_origination_domain_stuff"
