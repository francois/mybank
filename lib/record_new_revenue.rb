# coding: utf-8

class RecordNewRevenue
  def initialize(db, tz)
    @db, @tz = db, tz
  end

  attr_reader :db, :tz

  def call(child_id:, unit_amount:, count:, posted_on:)
    db[:public__transactions].insert(
      child_id: child_id,
      amount: unit_amount * count,
      posted_on: posted_on,
      description: sprintf("%d tâches complétées à %.2f%s$/tâche", count, unit_amount, NBSP))
  end
end
