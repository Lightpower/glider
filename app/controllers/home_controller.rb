# encoding: UTF-8
class HomeController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @tasks = Task.where("assigned_at > ?", Date.today)
  end
end
