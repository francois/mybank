require "base_action"
require "new_revenue_presenter"

class NewRevenueView < BaseAction
  def call(child_id:)
    person = find_person_with_id(child_id)
    NewRevenuePresenter.new(person: person, today: today, title: "Inscrire un revenu")
  end
end
