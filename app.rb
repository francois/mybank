require "bundler"
Bundler.require

begin
  require "dotenv"
rescue LoadError => _
  # in production, dotenv isn't loaded
end

configure do
  DB = Sequel.connect(ENV.fetch("DATABASE_URL"))
end

get "/" do
  "hello #{DB["SELECT version()"].to_a.inspect}"
end

get "/transactions/:child_id" do
end

get "/transactions/:child_id/new-revenue" do
end

get "/transactions/:child_id/new" do
end

post "/new-revenue/:child_id" do
end

post "/transactions/:child_id" do
end
