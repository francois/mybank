begin
  require "dotenv"
rescue LoadError => _
  # in production, dotenv isn't loaded
end

namespace :db do
  desc "Migrates the database to the most recent version"
  task :migrate do
    sh "sequel --echo --migrate-directory db/migrations #{ENV.fetch("DATABASE_URL")}"
  end
end

namespace :cron do
  desc "Runs daily tasks"
  task :daily => %w(app:apply_interests)
end

namespace :app do
  desc "Calculates due interest per child"
  task :apply_interests => %w(env) do
    require "apply_per_child_interests"
    ApplyPerChildInterests.new(DB, TZ).call
  end
end

desc "Loads the environment into the current process"
task :env do
  $LOAD_PATH.unshift File.expand_path("../lib", __FILE__) unless $LOAD_PATH.include?(File.expand_path("../lib", __FILE__))
  require "env"
end
