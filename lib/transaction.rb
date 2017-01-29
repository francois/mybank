class Transaction
  def initialize(id:, description:, amount:, posted_on:)
    @id, @description, @amount, @posted_on = id, description, amount, posted_on
  end

  attr_reader :id, :description, :amount, :posted_on
end
