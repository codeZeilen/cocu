require 'cucumber/rake/task'

namespace :cucumber do
  Cucumber::Rake::Task.new({:cocu => 'db:test:prepare'}, 'Run default profile with compact output') do |t|
    t.fork = true # You may get faster startup if you set this to false
    t.profile = 'default'
    t.cucumber_opts = ["--format cocu"]
  end
end

