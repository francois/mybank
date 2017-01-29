class Person
  def initialize(id:, name:)
    @id, @name = id, name
  end

  attr_reader :id, :name
end
