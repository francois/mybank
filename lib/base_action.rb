require "person"

class BaseAction
  def initialize(db, tz)
    @db, @tz = db, tz
  end

  attr_reader :db, :tz

  NotFound = Class.new(RuntimeError)

  def find_person_with_id(id)
    child  = db[:public__children].filter(id: id).first
    raise NotFound, "Could not find person with ID #{id.inspect}" unless child

    person = Person.new(
      id: child.fetch(:id),
      name: child.fetch(:name),
      task_rate: child.fetch(:task_rate))
  end

  def today
    @today ||= tz.now.to_date
  end
end