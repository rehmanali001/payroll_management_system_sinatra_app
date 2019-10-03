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
#    binding.pry
    if params[:name] == "" || params[:wage] == "" || params[:hours] == ""
      redirect '/employees/new'
    else
      @employee = Employee.create(params)
      redirect '/employees'
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
        if @employee && @employee.user == current_user(session)
        erb :"employees/edit"
      else
      redirect "/employees"
    end
    else
      redirect to '/login'
    end
  end

    patch '/employees/:id' do
      if is_logged_in?(session)
      if params[:name] == "" || params[:wage] == "" || params[:hours] == ""
        redirect "/employees/#{@employee.id}/edit"
    else
      @employee = Employee.find(params[:id])
      if @employees && @employees.user == current_user(session)
      if  @employee.update(name: params[:name], wage: params[:wage], hours: params[:hours])
        redirect to '/employees/#{employees.id}'
      else
        redirect to '/employees/#{@employee.id}/edit'
      end
    else
      redirect "/employees"
    end
    end
  else
    redirect to '/login'
  end
  end

delete '/employees/:id' do
  @employee = Employee.find(params[:id])
  # binding.pry
  if @employees && @employees.user == current_user(session)
    @employee.destroy
    redirect "/employees"
  else
    redirect "/login"
  end
  end
  end
