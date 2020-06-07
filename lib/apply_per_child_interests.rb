# coding: utf-8
require "base_action"
require "bigdecimal"
require "interest_calculator"

class ApplyPerChildInterests < BaseAction
  include InterestCalculator

  def call
    ds = db[:transactions].
      group_by(:family_id, :child_id).
      select{ [family_id, child_id, sum(amount)] }.
      from_self.select(:family_id, :child_id, :sum___balance)

    interests = ds.map do |row|
      family_id = row.fetch(:family_id)
      child_id  = row.fetch(:child_id)
      balance   = row.fetch(:balance)

      daily_interest = calculate_daily_interest_on(balance)

      [family_id,
       child_id,
       today,
       sprintf("Intérêts sur solde de %.2f%s$ (%.1f%%)", balance, NBSP, 100.0 * interest_rate),
       daily_interest.round(3)]
    end

    db[:transactions].import(
      %i[family_id child_id posted_on description amount],
      interests)
  end
end
