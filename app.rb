require "bundler"
Bundler.require

begin
  require "dotenv"
rescue LoadError => _
  # in production, dotenv isn't loaded
end

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require "home_view"
require "statement_view"

configure do
  TZ = TZInfo::Timezone.get("America/Montreal")
  DB = Sequel.connect(ENV.fetch("DATABASE_URL"))
  DB.run DB["SET timezone TO ?", TZ.name].sql
end

get "/" do
  @vm = HomeView.new(DB, TZ).call
  erb :home, layout: :application
end

get "/transactions/:child_id" do |child_id|
  @vm = StatementView.new(DB, TZ).call(child_id: Integer(child_id))
  erb :statement, layout: :application
end

get "/transactions/:child_id/new-revenue" do
end

get "/transactions/:child_id/new" do
end

post "/new-revenue/:child_id" do
  redirect "/"
end

post "/transactions/:child_id" do
  redirect "/"
end

helpers do
  def format_amount(amount)
    sprintf "%.2f", amount
  end
end
