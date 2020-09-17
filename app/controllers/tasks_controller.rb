# encoding: UTF-8
class TasksController < ApplicationController
  PERMITTED_PARAMS = %i[user_id name description assigned_at priority state category_name
                        category_id]

  before_action :authenticate_user!

  before_action :load_task, only: [:show, :edit, :update, :finish, :delete, :postpone]
  before_action :load_categories, only: [:show, :edit, :update, :delete]

  def index
  	@tasks = Task.for(current_user).future(Date.today).active.ordered
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    Task.create task_params
    redirect_to root_path
  end

  def edit
  end

  def update
    @task.update task_params
    redirect_to root_path
  end 

  def total
  	@active_date = Task.first_active_date_for(current_user)
  	if @active_date
  	  @tasks = Task.for(current_user).by_date(@active_date).active.ordered
  	else
  	  redirect_to root_path
  	end
  end

  # Ajax
  def finish
    result = @task.finish
    render text: result ? 'ok' : 'error'
  end

  # Ajax
  def delete
    result = @task.cancel
    render text: result ? 'ok' : 'error'
  end 

  # Ajax
  def postpone
    result = @task.postpone
    render text: result ? 'ok' : 'error'
  end

  private 

  def load_task
    @task = Task.find params[:id]
  end

  def load_categories
    @categories = current_user.categories
  end  

  def task_params
  	task_hash = params.require(:task).merge!(user_id: current_user.id)
    category_name = task_hash[:category_name]
    if category_name
      task_hash.merge!(category_id: handle_category_id(category_name)).delete(:category_name)
    end
    task_hash.permit(*PERMITTED_PARAMS)
  end

  def handle_category_id(category)
    category = Category.find_or_create_by(name: category, user_id: current_user.id)
    category.id
  end
end
