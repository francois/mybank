require "bundler"
Bundler.require

begin
  require "dotenv"
rescue LoadError => _
  # in production, dotenv isn't loaded
end

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

NBSP = " " # non-breaking space

require "home_view"
require "new_revenue_view"
require "new_transaction_view"
require "record_new_revenue"
require "record_new_transaction"
require "statement_view"

configure do
  TZ = TZInfo::Timezone.get("America/Montreal")
  DB = Sequel.connect(ENV.fetch("DATABASE_URL"))
  DB.run DB["SET timezone TO ?", TZ.name].sql
end

configure :production do
  use Rack::Auth::Basic, "Ma Banque" do |username, password|
    username == ENV.fetch("BASIC_AUTH_USERNAME") and password == ENV.fetch("BASIC_AUTH_PASSWORD")
  end
end

get "/" do
  @vm = HomeView.new(DB, TZ).call
  erb :home, layout: :application
end

get "/transactions/:child_id" do |child_id|
  @vm = StatementView.new(DB, TZ).call(child_id: Integer(child_id))
  erb :statement, layout: :application
end

get "/transactions/:child_id/new-revenue" do |child_id|
  @vm = NewRevenueView.new(DB, TZ).call(child_id: Integer(child_id))
  erb :new_revenue, layout: :application
end

get "/transactions/:child_id/new" do |child_id|
  @vm = NewTransactionView.new(DB, TZ).call(child_id: Integer(child_id))
  erb :new_transaction, layout: :application
end

post "/revenues/:child_id" do |child_id|
  revenue = params["revenue"]

  RecordNewRevenue.new(DB, TZ).call(
    child_id: Integer(child_id),
    count: Integer(revenue["count"]),
    posted_on: Date.parse(revenue["posted_on"]))
  redirect "/"
end

post "/transactions/:child_id" do |child_id|
  transaction = params["transaction"]

  RecordNewTransaction.new(DB, TZ).call(
    child_id: Integer(child_id),
    description: transaction["description"],
    amount: BigDecimal(transaction["amount"]),
    posted_on: Date.parse(transaction["posted_on"]))
  redirect "/"
end

helpers do
  def format_amount(amount)
    amount ? sprintf("%.2f%s$", amount, NBSP) : ""
  end
end
