# The ABC Experiment

Experiments with converting various numbers of `Foobara::Command`s commands into `Foobara::AgentBackedCommand`s
with various LLM models to see what happens.

## Usage

After a `bundle install` you should be able to then `cp .env.development.test .env.development.test.local`
and then you can update the values in `.env.development.test.local` 
depending on which you want to use among foobara-ollama-api, foobara-anthropic-api, and foobara-open-ai-api.
Re: Olloma, note that model lists are cached in `tmp/cached_command/` so delete that directory if you 
pull new models that you want to use.

Then, you can setup some demo data with:

`./prepare-loan-records`

And then you can see a summary of the data with:

`./generate-loan-files-report`

And you can run ReviewAllLoanFiles command with:

`./review-all-loan-files`

In that file, you can choose whether to use LLMs (`use_abc`) and which LLM model to use (`llm_model`)
and also which versions of which files to load.

## Links

- [foobara](https://foobara.com) (the framework this is based on)
- [foobara-agent-backed-command](https://github.com/foobara/agent-backed-command) (the main gem this experiments with)

## Want help playing with this?

You can reach out if you'd like help playing with these scripts! There's contact info here: https://foobara.com/contact

## Contributing

If this project or any of the above mentioned projects seem interesting and you want help building stuff
with them or you want to contribute to them, please get in touch!

Bug reports and pull requests are welcome on GitHub
at https://github.com/foobara-demo/abc-experiment

## License

This project is licensed under the MPL-2.0 license. Please see LICENSE.txt for more info.
