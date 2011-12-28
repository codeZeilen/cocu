require 'cucumber/formatter/cocu'

# Extend Cucumber's builtin formats, so that this
# formatter can be used with --format fuubar
require 'cucumber/cli/options'

Cucumber::Cli::Options::BUILTIN_FORMATS["cocu"] = [
   "Cucumber::Formatter::CoCu",
   "The compact cucumber format showing only what you need."
]

module Cocu
  class Tasks < Rails::Railtie
    rake_tasks do
      load "tasks/cocu.rake"
    end
  end
end
