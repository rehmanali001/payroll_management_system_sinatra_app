class EmployeesController < ApplicationController

  get '/employees' do
    redirect_if_not_logged_in
      @employees = Employee.all
      erb :'/employees/employees'
  end

    post '/employees' do
      redirect_if_not_logged_in
      if params[:name] == "" || params[:wage] == "" || params[:hours] == ""
        redirect '/employees/new'
      else
        @employee = Employee.create(params)
        @employee.user_id = current_user.id
        @employee.save
        redirect '/employees'
      end
    end

    get '/employees/new' do
      redirect_if_not_logged_in
        erb :"/employees/new"
    end

    get '/employees/:id' do
      redirect_if_not_logged_in
        @employee = Employee.find(params[:id])
        erb :"employees/show"
    end

    get '/employees/:id/edit' do
      redirect_if_not_logged_in
      @employee = Employee.find(params[:id])
      if is_logged_in? && @employee.user_id == current_user.id
          erb :"employees/edit"
        else
          redirect "/login"
        end
      end

    patch '/employees/:id' do
      redirect_if_not_logged_in
      @employee = Employee.find(params[:id])
        if params[:name] == "" || params[:wage] == "" || params[:hours] == ""
          redirect "/employees/#{@employee.id}/edit"
        end
          if @employee.user_id == current_user.id
            @employee.update(name: params[:name], wage: params[:wage], hours: params[:hours])
              redirect "/employees"
          end
    end

    delete '/employees/:id' do
      redirect_if_not_logged_in
      @employee = Employee.find(params[:id])
      # binding.pry
      if @employee.user_id == current_user.id
        @employee.destroy
        redirect "/employees"
      end
    end
end
