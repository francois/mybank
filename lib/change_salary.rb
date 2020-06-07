require "base_action"

class ChangeSalary < BaseAction
  def call(family_id:, id:, task_rate:)
    person = find_person_with_id(family_id: family_id, id: id)
    db[:children].
      filter(family_id: person.family_id, id: person.id).
      update(task_rate: task_rate)
  end
end
