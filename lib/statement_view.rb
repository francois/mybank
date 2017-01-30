require "base_action"
require "statement_presenter"
require "transaction"

class StatementView < BaseAction
  def call(family_id:, child_id:)
    person = find_person_with_id(family_id: family_id, id: child_id)

    txns = db[:public__transactions].
      select_all(:transactions).
      select_append(Sequel.lit("sum(amount) OVER (ORDER BY posted_on, created_at)").as(:running_balance)).
      filter(child_id: child_id).
      order(:posted_on, :created_at).
      all

    transactions = txns.map do |txn|
      Transaction.new(
        id: txn.fetch(:id),
        description: txn.fetch(:description),
        amount: txn.fetch(:amount),
        running_balance: txn.fetch(:running_balance),
        posted_on: txn.fetch(:posted_on))
    end

    StatementPresenter.new(person: person, today: today, transactions: transactions)
  end
end
