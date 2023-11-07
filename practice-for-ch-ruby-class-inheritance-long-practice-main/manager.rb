require_relative 'employee'

class Manager < Employee
  attr_reader :subordinates

  def initialize(name, title, salary, boss, subordinates)
    super(name, title, salary, boss)
    @subordinates = subordinates
  end

  def bonus(multiplier)
    salary = 0
    managers = subordinates.select { |subordinate| subordinate.is_a?(Manager) }
    managers.each { |manager| salary += manager.subordinates.map(&:salary).sum }
    (subordinates.map(&:salary).sum + salary) * multiplier
  end
end

david = Employee.new("David", "TA", 10000, "Darren")
shawna = Employee.new("Shawna", "TA", 12000, "Darren")
darren = Manager.new("Darren", "TA Manager", 78000, "Ned", [david, shawna])
ned = Manager.new("Ned", "Founder", 1000000, nil, [darren])

p ned.bonus(5)
p darren.bonus(4)
p david.bonus(3)
