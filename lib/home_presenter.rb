class HomePresenter
  def initialize(children:, balances:, today:)
    @children = children
    @balances = balances
    @today = today
  end

  attr_reader :children, :balances, :today

  def each_child_and_balance
    children.each do |child|
      balance = balances.fetch(child.id, BigDecimal(0))
      yield child, balance
    end
  end
end
