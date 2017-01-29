require "home_presenter"
require "person"

class HomeView
  def initialize(db, tz)
    @db = db
    @tz = tz
  end

  attr_reader :db, :tz

  def call
    children = db[:public__children].
      order{ lower(name) }.
      map{|row| Person.new(id: row.fetch(:id), name: row.fetch(:name))}

    balances = db[:public__transactions].
      group_by(:child_id).
      select{ [child_id, sum(amount)] }.
      from_self.select_hash(:child_id, :sum)

    today = tz.now.to_date
    HomePresenter.new(children: children, balances: balances, today: today)
  end
end
