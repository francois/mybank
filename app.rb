require "bundler"
Bundler.require

begin
  require "dotenv"
rescue LoadError => _
  # in production, dotenv isn't loaded
end

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require "env"
require "home_view"
require "new_revenue_view"
require "new_transaction_view"
require "record_new_revenue"
require "record_new_transaction"
require "statement_view"

get "/:family_id" do |family_id|
  @vm = HomeView.new(DB, TZ).call(family_id: family_id)
  erb :home, layout: :application
end

get "/:family_id/transactions/:child_id" do |family_id, child_id|
  @vm = StatementView.new(DB, TZ).call(family_id: family_id, child_id: child_id)
  erb :statement, layout: :application
end

get "/:family_id/transactions/:child_id/new-revenue" do |family_id, child_id|
  @vm = NewRevenueView.new(DB, TZ).call(family_id: family_id, child_id: child_id)
  erb :new_revenue, layout: :application
end

get "/:family_id/transactions/:child_id/new" do |family_id, child_id|
  @vm = NewTransactionView.new(DB, TZ).call(family_id: family_id, child_id: child_id)
  erb :new_transaction, layout: :application
end

post "/:family_id/revenues/:child_id" do |family_id, child_id|
  revenue = params["revenue"]

  RecordNewRevenue.new(DB, TZ).call(
    family_id: family_id,
    child_id: child_id,
    count: Integer(revenue["count"]),
    posted_on: Date.parse(revenue["posted_on"]))
  redirect "/#{family_id}"
end

post "/:family_id/transactions/:child_id" do |family_id, child_id|
  transaction = params["transaction"]

  RecordNewTransaction.new(DB, TZ).call(
    family_id: family_id,
    child_id: child_id,
    description: transaction["description"],
    amount: BigDecimal(transaction["amount"]),
    posted_on: Date.parse(transaction["posted_on"]))
  redirect "/#{family_id}"
end

helpers do
  def format_amount(amount)
    real_amount = amount || BigDecimal(0)
    sprintf("%.2f%s$", real_amount, NBSP)
  end
end
