require "interest_calculator"

class Goal
  include InterestCalculator

  def initialize(id:, child_id:, name:, amount:, task_rate:)
    @id, @child_id, @name, @amount = id, child_id, name, amount
    @task_rate = task_rate
  end

  attr_reader :id, :child_id, :name, :amount, :task_rate

  def weeks_to_reach_goal(balance:, tasks_per_week:)
    amount_missing = (amount - balance)
    return 0 if amount_missing < 0

    weekly_salary    = tasks_per_week * task_rate
    daily_interest   = calculate_daily_interest_on(balance)
    weekly_interests = daily_interest * 7

    balance_increase_per_week = weekly_salary + weekly_interests
    (amount_missing / balance_increase_per_week).ceil
  end
end
