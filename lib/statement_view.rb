require "statement_presenter"
require "transaction"

class StatementView
  def initialize(db, tz)
    @db, @tz = db, tz
  end

  attr_reader :db, :tz

  def call(child_id:)
    child  = db[:public__children].filter(id: child_id).first
    person = Person.new(id: child.fetch(:id), name: child.fetch(:name), task_rate: child.fetch(:task_rate))
    today  = tz.now.to_date

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
