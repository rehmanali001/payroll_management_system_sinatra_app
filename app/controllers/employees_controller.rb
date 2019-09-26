class EmployeesController < ApplicationController

  get '/employees' do
    @employees = Employee.all
    erb :'/employees/employees'
  end
end
