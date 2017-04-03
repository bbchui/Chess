require_relative 'Employee'

class Manager < Employee
  attr_accessor :employees

  def initialize(name, title, salary, boss = nil, employees = [])
    super(name, title, salary, boss)
    @employees = employees
  end

  def bonus(multiplier)
    salaries = []
    @employees.each do |el|
      salaries << el.salary
    end

    salaries.inject(&:+) * multiplier
  end

  def set_employee(employee)
    @employees << employee
    boss.set_employee(employee) unless self.boss.nil?
  end

end
