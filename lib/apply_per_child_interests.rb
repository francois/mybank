# coding: utf-8
require "base_action"
require "bigdecimal"

class ApplyPerChildInterests < BaseAction
  def call
    ds = db[:public__transactions].
      group_by(:family_id, :child_id).
      select{ [family_id, child_id, sum(amount)] }.
      from_self.select(:family_id, :child_id, :sum___balance)

    interests = ds.map do |row|
      rate = 0.1 # TODO: Make configurable

      family_id = row.fetch(:family_id)
      child_id  = row.fetch(:child_id)
      balance   = row.fetch(:balance)
      interest  = balance * rate / 365
      if interest < 0 then
        interest = BigDecimal("-0.01") if interest > BigDecimal("-0.01")
      else
        interest = BigDecimal("0.01") if interest < BigDecimal("0.01")
      end

      [family_id,
       child_id,
       today,
       sprintf("Intérêts sur solde de %.2f%s$ (%.1f%%)", balance, NBSP, 100.0 * rate),
       interest.round(3)]
    end

    db[:public__transactions].import(
      %i[family_id child_id posted_on description amount],
      interests)
  end
end
