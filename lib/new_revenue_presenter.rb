class NewRevenuePresenter
  def initialize(person:, today:)
    @person, @today = person, today
  end

  attr_reader :person, :today

  def person_id
    person.id
  end

  def person_name
    person.name
  end
end
