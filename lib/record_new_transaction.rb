class RecordNewTransaction
  def initialize(db, tz)
    @db, @tz = db, tz
  end

  attr_reader :db, :tz

  NBSP = " " # non-breaking space

  def call(child_id:, amount:, description:, posted_on:)
    db[:public__transactions].insert(
      child_id: child_id,
      amount: amount,
      posted_at: posted_on,
      description: description)
  end
end
