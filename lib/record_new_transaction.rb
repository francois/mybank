require "base_action"

class RecordNewTransaction < BaseAction
  def call(child_id:, amount:, description:, posted_on:)
    person = find_person_with_id(child_id)

    db[:public__transactions].insert(
      child_id: child_id,
      amount: amount,
      posted_on: posted_on,
      description: description)
  end
end
