require "base_action"
require "statement_presenter"
require "transaction"

class StatementView < BaseAction
  def call(child_id:)
    person = find_person_with_id(child_id)

    txns = db[:public__transactions].filter(child_id: child_id).order(:posted_on, :created_at).all
    transactions = txns.map do |txn|
      Transaction.new(
        id: txn.fetch(:id),
        description: txn.fetch(:description),
        amount: txn.fetch(:amount),
        posted_on: txn.fetch(:posted_on))
    end

    StatementPresenter.new(person: person, today: today, transactions: transactions)
  end
end
