# coding: utf-8

class RecordNewRevenue
  def initialize(db, tz)
    @db, @tz = db, tz
  end

  attr_reader :db, :tz

  def call(child_id:, count:, posted_on:)
    rate = db[:public__children].filter(id: child_id).select_map(:task_rate).first
    raise ArgumentError, "Unknown child: #{child_id.inspect}" unless rate

    db[:public__transactions].insert(
      child_id: child_id,
      amount: rate * count,
      posted_on: posted_on,
      description: sprintf("%d tâches complétées à %.2f%s$/tâche", count, rate, NBSP))
  end
end
