require "base_action"

class RecordNewGoal < BaseAction
  def call(family_id:, child_id:, name:, amount:)
    person = find_person_with_id(family_id: family_id, id: child_id)
    db[:goals].insert(
      child_id: person.id,
      name: name,
      amount: amount)
  end
end
