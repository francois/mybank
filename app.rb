require "bundler"
Bundler.require

begin
  require "dotenv"
rescue LoadError => _
  # in production, dotenv isn't loaded
end

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require "change_salary"
require "change_salary_view"
require "delete_goal"
require "env"
require "home_view"
require "new_goal_view"
require "new_revenue_view"
require "new_transaction_view"
require "record_new_goal"
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

get "/:family_id/person/:child_id/edit" do |family_id, child_id|
  @vm = ChangeSalaryView.new(DB, TZ).call(family_id: family_id, id: child_id)
  erb :change_salary, layout: :application
end

post "/:family_id/person/:child_id" do |family_id, child_id|
  ChangeSalary.new(DB, TZ).call(
    family_id: family_id,
    id: child_id,
    task_rate: BigDecimal(params["person"]["task_rate"]))
  redirect "/#{family_id}"
end

get "/:family_id/person/:child_id/goals/new" do |family_id, child_id|
  @vm = NewGoalView.new(DB, TZ).call(family_id: family_id, child_id: child_id)
  erb :new_goal, layout: :application
end

post "/:family_id/person/:child_id/goal/:goal_id" do |family_id, child_id, goal_id|
  DeleteGoal.new(DB, TZ).call(
    family_id: family_id,
    child_id: child_id,
    id: goal_id)
  redirect "/#{family_id}/transactions/#{child_id}"
end

post "/:family_id/person/:child_id/goals" do |family_id, child_id|
  RecordNewGoal.new(DB, TZ).call(
    family_id: family_id,
    child_id: child_id,
    name: params["goal"]["name"],
    amount: BigDecimal(params["goal"]["amount"]))

  redirect "/#{family_id}/transactions/#{child_id}"
end

helpers do
  def format_amount(amount)
    real_amount = amount || BigDecimal(0)
    sprintf("%.2f%s$", real_amount, NBSP)
  end
end
