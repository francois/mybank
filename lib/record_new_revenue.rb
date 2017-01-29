# coding: utf-8

class RecordNewRevenue
  def initialize(db, tz)
    @db, @tz = db, tz
  end

  attr_reader :db, :tz

  NBSP = " " # non-breaking space

  def call(child_id:, unit_amount:, count:, posted_on:)
    db[:public__transactions].insert(
      child_id: child_id,
      amount: unit_amount * count,
      posted_at: posted_on,
      description: "#{count} tâches complétées à #{unit_amount.to_s("F")}#{NBSP}$")
  end
end
