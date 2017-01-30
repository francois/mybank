class Transaction
  def initialize(id:, description:, amount:, posted_on:, running_balance:)
    @id, @description, @amount, @posted_on = id, description, amount, posted_on
    @running_balance = running_balance
  end

  attr_reader :id, :description, :amount, :posted_on, :running_balance
end
