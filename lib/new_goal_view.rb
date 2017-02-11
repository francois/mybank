require "base_action"
require "new_goal_presenter"

class NewGoalView < BaseAction
  def call(family_id:, child_id:)
    person = find_person_with_id(family_id: family_id, id: child_id)
    NewGoalPresenter.new(person, title: "Nouveau but")
  end
end
