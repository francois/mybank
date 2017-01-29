class Transaction
  def initialize(id:, description:, amount:, posted_at:)
    @id, @description, @amount, @posted_at = id, description, amount, posted_at
  end

  attr_reader :id, :description, :amount, :posted_at

  def posted_on
    posted_at.to_date
  end
end
