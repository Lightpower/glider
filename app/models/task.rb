# encoding: UTF-8
class Task < ActiveRecord::Base
  ACTIVE = 0
  FINISHED = 1
  CANCELED = 2  

  belongs_to :user
  belongs_to :category
  has_many :task_actions

  scope :for, ->(user) { where(user: user) }  
  scope :by_date, ->(date) do 
    where("assigned_at >= ? AND assigned_at <= ?", 
          date.beginning_of_day, 
          (date+1.day).beginning_of_day) 
  end  
  scope :future, ->(date) { where("assigned_at >= ?", date.beginning_of_day) }  
  scope :active, -> { where(state: ACTIVE) }  
  scope :ordered, -> { order('assigned_at, priority DESC') }  

  def finish
    self.update(state: FINISHED)
  end

  def cancel
    self.update(state: FINISHED)
  end

  def postpone
    self.update(assigned_at: self.assigned_at + 1.day)
  end

  def category_name
  	category&.name
  end

  def assigned_at_date
  	assigned_at.strftime('%d.%m')
  end

  def self.first_active_date_for(user)
    active_date = self.for(user).active.order(:assigned_at).first&.assigned_at
    active_date < Date.today ?  active_date : nil
  end
end