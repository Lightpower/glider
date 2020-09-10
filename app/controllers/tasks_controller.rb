# encoding: UTF-8
class TasksController < ApplicationController
  PERMITTED_PARAMS = %i[user_id name description assigned_at priority state category category_id]

  before_action :authenticate_user!

  before_action :load_task, only: [:show, :edit, :update, :delete]
  before_action :load_categories, only: [:show, :edit, :update, :delete]

  def index
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    Task.create task_params
    render 'index'
  end

  def edit
  end

  def update
    @task.update task_params
  end 

  def finish
  end

  def delete
  end

  def postpone
  end

  private 

  def load_task
    @task = Task.find params[:task_id]
  end

  def load_categories
    @categories = current_user.categories
  end  

  def task_params
  	byebug
  	task_hash = params.require(:task).merge!(user_id: current_user.id)
    category = task_hash[:category]
    if category
      task_hash.merge!(category_id: handle_category_id(category)).delete(:category)
    end
    task_hash.permit(*PERMITTED_PARAMS)
  end

  def handle_category_id(category)
    category = Category.find_or_create_by(name: category, user_id: current_user.id)
    category.id
  end
end
