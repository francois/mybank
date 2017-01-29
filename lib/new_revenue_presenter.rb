class NewRevenuePresenter
  def initialize(person:, today:, title:)
    @person, @today, @title = person, today, title
  end

  attr_reader :person, :today, :title

  def person_id
    person.id
  end

  def person_name
    person.name
  end
end
