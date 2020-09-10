# encoding: UTF-8
class Task < ActiveRecord::Base
  ACTIVE = 0
  FINISHED = 1
  CANCELED = 2  

  belongs_to :user
  belongs_to :category
  has_many :task_actions

  def finish
    self.update(state: FINISHED)
  end

  def cancel
    self.update(state: FINISHED)
  end

  def postpone
    self.update(assigned_at: self.assigned_at + 1.day)
  end
end