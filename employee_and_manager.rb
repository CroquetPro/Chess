class Employee
  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary, boss)
    @name, @title, @salary, @boss = name, title, salary, boss
  end

  def bonus(multiplier)
    self.salary * multiplier
  end




end

class Manager < Employee
  attr_reader :employees

  def initialize(name, title, salary, boss, employees)
    super(name, title, salary, boss)
    @employees = employees
  end

  def add_employees(employee)
    @employees << employee if employee.boss == self
    @employees << employee.employees if employee.is_a?(Manager)
    @employees = @employees.flatten
  end

  def bonus(multiplier)
    total = 0

    employees.each do |employee|
      total += employee.salary if employee.is_a?(Employee)
    end

    total * multiplier
  end

end


ned = Manager.new("Ned", "Founder", 1_000_000, nil, [])
darren = Manager.new("Darren", "TA Manager", 78_000, ned, [])
shawna = Employee.new("Shawna", "TA", 12_000, darren)
david = Employee.new("David", "TA", 10_000, darren)

darren.add_employees(shawna)
darren.add_employees(david)
ned.add_employees(darren)

p ned.bonus(5)
p darren.bonus(4)
p david.bonus(3)
