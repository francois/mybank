require "new_revenue_presenter"
require "person"

class NewTransactionView
  def initialize(db, tz)
    @db, @tz = db, tz
  end

  attr_reader :db, :tz

  def call(child_id:)
    child  = db[:public__children].filter(id: child_id).first
    person = Person.new(id: child.fetch(:id), name: child.fetch(:name))
    today  = tz.now.to_date

    NewRevenuePresenter.new(person: person, today: today, title: "Inscrire une transaction manuelle")
  end
end
