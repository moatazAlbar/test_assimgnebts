require 'date'

employees = [{
  emp_id: 1,
  name: 'Ahmed',
  joining_date: Date.new(2018,11,1),
  department: 'back-end',
  salary: 20000
  },
  {
    emp_id: 2,
    name: 'Ahmed2',
    joining_date: Date.new(2022,11,1),
    department: 'front-end',
    salary: 20
    },
  {
    emp_id: 3,
    name: 'Ahmed3',
    joining_date: Date.new(2012,11,1),
    department: 'back-end',
    salary: 2000
    },
    {
      emp_id: 4,
      name: 'Ahmed4',
      joining_date: Date.new(2016,11,1),
      department: 'front-end',
      salary: 200
      },

]

def find_employee(employees, employee_id)
  employee = employees.find { |employee| employee[:emp_id] == employee_id}
end

def add_employee(employees, name, joining_date, department, salary)
  employees << { emp_id: employees[-1][:emp_id] + 1, name: name,
    joining_date: joining_date, department: department,salary: salary
  }
end

def update_employee(employees, emp_id, option={})
  employee = find_employee(employees, emp_id)
  update_employee = {
    emp_id: emp_id,
    name: option[:name] || employee[:name],
    joining_date: option[:joining_date] || employee[:joining_date],
    department: option[:department] || employee[:department],
    salary: option[:salary] || employee[:salary]
  }
  employees.map! do |emp|
    emp[:emp_id] == update_employee[:emp_id] ? update_employee : emp
  end
end

def delete_employee(employees, employee_id)
  employees.map! do |employee|
    unless employee[:emp_id] == employee_id
      employee
    end
  end
  employees.compact!
end

def search_employee(employees, search)
  if search.to_i != 0
    find_employee(employees,search.to_i)
  else
    employees.find { |employee| employee[:name] == search }
  end
end

def sort_employee(employees, arg, des = true)
  employees.sort do  |emp1, emp2|
    if des == true
      emp1[arg] <=> emp2[arg]
    else
      emp2[arg] <=> emp1[arg]
    end
  end
end

def report_employees(employees)
  employees.each do |employee|
    puts "#{employee[:emp_id]}, #{employee[:name]}, #{employee[:joining_date]}, #{employee[:department]}, #{employee[:salary]}"
  end
end

def employees_department_total_salaries(employees)
  employees.group_by{|employee| employee[:department]}.then do |employees|
    employees.each do |department, employee|
      total_salary = employee.sum {|employee| employee[:salary]}
      puts "total salary for #{department} is #{total_salary}"
    end
  end
end

def first_last_employees_join (employees, des = 'both')
  employees.sort! do |emp1, emp2|
    emp1[:joining_date] <=> emp2[:joining_date]
  end
  case des
    when 'first'
      employees.first
    when 'last'
      employees.last
    when 'both'
      %(
      the first employee
      #{employees.first}
      and the last employee
      #{employees.last} )
  end
end

def low_and_high_employee_salary(employees,des = 'both')
  employees.sort! do  |emp1, emp2|
    emp1[:salary] <=> emp2[:salary]
  end
  case des
    when 'low'
      employees.first
    when 'high'
      employees.last
    when 'both'
      %(
      the low employee salary
      #{employees.first}
      and the high employee salary
      #{employees.last})
  end
end

while true
  puts %(
    welcom to employee manager app
    enter 1 for add new employee
    enter 2 for update employee
    enter 3 for delete employee
    enter 4 for search an employee
    enter 5 for sort employee
    enter 6 for make report employees
    enter 7 for display departments and total salary
    enter 8 for display first or last employee joined
    enter 9 for display low or high employee salary
    enter anything else to exit
  )
  choise=gets.chomp.to_i
  case choise
    when 1
      add_employee(employees, 'moataz2', Date.new(2022,2,1), 'full-stack2', 50020)
    when 2
      puts 'please, enter id of employee to update'
      employee_id=gets.to_i
      update_employee(employees, employee_id, { name: 'moataz',salary: 5020 })

    when 3
      puts 'please, enter id of employee to delete'
      employee_id=gets.to_i
      delete_employee(employees, employee_id)
    when 4
      puts 'please, enter id or Name of employee'
      search=gets.chomp
      puts search_employee(employees, search)
    when 5
      puts %(
        enter 1 for order employee ASC by name
        enter 2 for order employee DES by name
        enter 3 for order employee ASC by salary
        enter 4 for order employee DES by salary
      )
      choise=gets.chomp.to_i
      puts \
      (case choise
        when 1
          sort_employee(employees,:name)
        when 2
          sort_employee(employees,:name, false)
        when 3
          sort_employee(employees,:salary)
        when 4
          sort_employee(employees,:salary, false)
        else
          'chose wrong'
      end)
    when 6
      report_employees(employees)
    when 7
      employees_department_total_salaries(employees)
    when 8
      puts 'please, enter 1 for first, 2 for last or any thing for both'
      choise=gets.chomp.to_i
      puts \
      (case choise
        when 1
          first_last_employees_join(employees, 'first')
        when 2
          first_last_employees_join(employees, 'last')
        else
          first_last_employees_join(employees)
      end)
    when 9
      puts 'please, enter 1 for low, 2 for high or anything for both'
      choise=gets.chomp.to_i
      puts \
      (case choise
        when 1
          low_and_high_employee_salary(employees, 'low')
        when 2
          low_and_high_employee_salary(employees, 'high')
        else
          low_and_high_employee_salary(employees)
      end)
    else
      abort ('thank you for use us')
  end
end
