require "base_action"
require "change_salary_presenter"

class ChangeSalaryView < BaseAction
  def call(family_id:, id:)
    person = find_person_with_id(family_id: family_id, id: id)
    ChangeSalaryPresenter.new(person: person, today: today)
  end
end
