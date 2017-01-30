# coding: utf-8

class HomePresenter
  def initialize(family_id:, children:, balances:, today:)
    @family_id = family_id
    @children = children
    @balances = balances
    @today = today
  end

  attr_reader :children, :balances, :today, :family_id

  def each_child_and_balance
    children.each do |child|
      balance = balances.fetch(child.id, BigDecimal(0))
      yield child, balance
    end
  end

  def title
    "État des soldes"
  end
end
