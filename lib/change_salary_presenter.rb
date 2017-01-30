class ChangeSalaryPresenter
  def initialize(person:, today:)
    @person = person
    @today = today
  end

  attr_reader :today

  def person_name
    @person.name
  end

  def family_id
    @person.family_id
  end

  def child_id
    @person.id
  end

  def task_rate
    @person.task_rate
  end
end
