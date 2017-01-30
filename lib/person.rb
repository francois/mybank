class Person
  def initialize(id:, name:, task_rate:)
    @id, @name = id, name
    @task_rate = task_rate
  end

  attr_reader :id, :name, :task_rate
end
