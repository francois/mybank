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
