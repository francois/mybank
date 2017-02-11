class NewGoalPresenter
  def initialize(person, title:)
    @person = person
    @title = title
  end

  attr_reader :person, :title

  def family_id
    person.family_id
  end

  def person_id
    person.id
  end

  def person_name
    person.name
  end
end
