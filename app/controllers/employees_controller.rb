class EmployeesController < ApplicationController

  get '/employees' do
    if is_logged_in?
      @user = current_user
      @employees = Employee.all
      erb :'/employees/employees'
    else
      redirect '/login'
    end
    end

    post '/employees' do
      binding.pry
      @user = current_user
    if params[:name] == "" || params[:wage] == "" || params[:hours] == ""
      redirect '/employees/new'
    else
      @employee = Employee.create(params)
      redirect '/employees'
    end
    end



  get '/employees/new' do
    if is_logged_in?
      @user = current_user
      erb :"/employees/new"
    else
      redirect "/login"
  end
  end

  get '/employees/:id' do
    if is_logged_in?
      @employee = Employee.find(params[:id])

      erb :"employees/show"
    else
      redirect "/login"
    end
    end

    get '/employees/:id/edit' do
      if is_logged_in?
        @employee = Employee.find(params[:id])
        erb :"employees/edit"
      else
      redirect "/login"
    end
    end

    patch '/employees/:id' do
      @employee = Employee.find(params[:id])
      if params[:name] == "" || params[:wage] == "" || params[:hours] == ""
        redirect "/employees/#{@employee.id}/edit"
    end
    if current_user.id == @user.id
      @employee.update(name: params[:name], wage: params[:wage], hours: params[:hours])
      redirect "/employees"
    end
    end

delete '/employees/:id' do
  @employee = Employee.find(params[:id])
  # binding.pry
  if current_user.id == @user.id
    @employee.destroy
    redirect "/employees"
  else
    redirect "/employees"
  end
  end
end
