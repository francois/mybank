# coding: utf-8

class StatementPresenter
  def initialize(person:, today:, transactions:)
    @person       = person
    @today        = today
    @transactions = transactions
  end

  attr_reader :person, :today, :transactions

  def person_name
    person.name
  end

  def balance
    transactions.map(&:amount).reduce(&:+)
  end

  def each_transaction(&block)
    transactions.each(&block)
  end

  def title
    "État de compte : #{person.name}"
  end
end
