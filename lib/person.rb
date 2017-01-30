class Person
  def initialize(family_id:, id:, name:, task_rate:)
    @family_id = family_id
    @id, @name = id, name
    @task_rate = task_rate
  end

  attr_reader :id, :name, :task_rate, :family_id
end
