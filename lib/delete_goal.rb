require "base_action"

class DeleteGoal < BaseAction
  def call(family_id:, child_id:, id:)
    db[:public__goals].
      filter(child_id: child_id, id: id).
      delete
  end
end
