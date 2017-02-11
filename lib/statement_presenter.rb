# coding: utf-8

class StatementPresenter
  def initialize(person:, today:, transactions:, goals:)
    @person       = person
    @today        = today
    @transactions = transactions
    @goals        = goals
  end

  attr_reader :person, :today, :transactions, :goals

  def family_id
    person.family_id
  end

  def child_id
    person.id
  end

  def person_name
    person.name
  end

  def balance
    transactions.map(&:amount).reduce(&:+)
  end

  def each_goal(&block)
    goals.each(&block)
  end

  def each_transaction(&block)
    transactions.each(&block)
  end

  def has_no_goals?
    goals.empty?
  end

  def title
    "État de compte : #{person.name}"
  end
end
