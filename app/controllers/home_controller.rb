# encoding: UTF-8
class HomeController < ApplicationController
  before_action :authenticate_user!
  
  def index
    if Task.first_active_date_for(current_user)    	
      redirect_to total_tasks_path
    else
      @tasks = Task.for(current_user).by_date(Date.today).active.ordered
    end
  end
end
