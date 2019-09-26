class EmployeesController < ApplicationController

  get '/employees' do
    if is_logged_in?(session)
      @user = current_user(session)
      @employees = Employee.all
      erb :'/employees/employees'
    else
      redirect '/login'
    end
  end





end
