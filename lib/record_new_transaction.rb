require "base_action"

class RecordNewTransaction < BaseAction
  def call(family_id:, child_id:, amount:, description:, posted_on:)
    person = find_person_with_id(family_id: family_id, id: child_id)

    db[:public__transactions].insert(
      family_id: person.family_id,
      child_id: person.id,
      amount: amount,
      posted_on: posted_on,
      description: description)
  end
end
