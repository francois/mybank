# coding: utf-8
require "base_action"

class ApplyPerChildInterests < BaseAction
  # Applies interest for Date.today (which is probably in UTC time)
  def call
    ds = db[:public__transactions].
      group_by(:child_id).
      select{ [child_id, sum(amount)] }.
      from_self.select(:child_id, :sum___balance)

    interests = ds.map do |row|
      rate = 0.1 # TODO: Make configurable

      child_id = row.fetch(:child_id)
      balance  = row.fetch(:balance)
      interest = balance * rate / 365

      [child_id,
       Date.today,
       sprintf("Intérêts sur solde de %.2f%s$ (%.1f%%)", balance, NBSP, 100.0 * rate),
       interest.round(3)]
    end

    db[:public__transactions].import(
      %i[child_id posted_on description amount],
      interests)
  end
end