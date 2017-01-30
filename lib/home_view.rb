require "home_presenter"
require "person"

class HomeView
  def initialize(db, tz)
    @db = db
    @tz = tz
  end

  attr_reader :db, :tz

  def call(family_id:)
    children = db[:public__children].
      filter(family_id: family_id).
      order{ lower(name) }.
      map{|row| Person.new(family_id: row.fetch(:family_id), id: row.fetch(:id), name: row.fetch(:name), task_rate: row.fetch(:task_rate))}

    balances = db[:public__transactions].
      group_by(:child_id).
      select{ [child_id, sum(amount)] }.
      from_self.select_hash(:child_id, :sum)

    today = tz.now.to_date
    HomePresenter.new(family_id: family_id, children: children, balances: balances, today: today)
  end
end
