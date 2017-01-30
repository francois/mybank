class NewRevenuePresenter
  def initialize(person:, today:, title:)
    @person, @today, @title = person, today, title
  end

  attr_reader :person, :today, :title, :task_rate

  def family_id
    person.family_id
  end

  def person_id
    person.id
  end

  def person_name
    person.name
  end

  def task_rate
    person.task_rate
  end
end
