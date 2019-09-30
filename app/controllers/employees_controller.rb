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

    post '/employees' do
      @user = current_user(session)
    if !params.empty?
      @user.employees << Employee.create(params)
      @employee = Employee.last

      erb :"/employees/edit"
    else
      redirect '/employees/new'
    end
    end

  get '/employees/new' do
      if is_logged_in?(session)
      @user = current_user(session)
      erb :"/employees/new"
    else
      redirect "/login"
  end
  end

  get '/employees/:id' do
    if is_logged_in?(session)
      @employee = Employee.find(params[:id])

      erb :"employees/show"
    else
      redirect "/login"
    end
    end

    get '/employees/:id/edit' do
      if is_logged_in?(session)
        @employee = Employee.find(params[:id])

        erb :"employees/edit"
      else
      redirect "/login"
    end
    end

    patch '/employees/:id' do
      @employee = Employee.find(params[:id])
    if params.empty?
        redirect "/employees/#{@employee.id}/edit"
    end
    if current_user(session).id == @user.id
      @employee.update(name: params[:name])
      @employee.update(wage: params[:wage])
      @employee.update(hours: params[:hours])

      redirect "/employees"
    end
    end

delete '/employees/:id' do
  @employee = Employee.find(params[:id])
  # binding.pry
  if current_user(session).id == @user.id
    @employee.destroy
    redirect "/employees"
  else
    redirect "/employees"
  end
  end
end
