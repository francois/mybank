# coding: utf-8
require "base_action"

class RecordNewRevenue < BaseAction
  def call(family_id:, child_id:, count:, posted_on:)
    person = find_person_with_id(family_id: family_id, id: child_id)

    db[:transactions].insert(
      family_id: person.family_id,
      child_id: person.id,
      amount: person.task_rate * count,
      posted_on: posted_on,
      description: sprintf("%d tâches complétées à %.2f%s$/tâche", count, person.task_rate, NBSP))
  end
end
