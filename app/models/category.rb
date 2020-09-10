# encoding: UTF-8
class Category < ActiveRecord::Base

  scope :for, -> (user) { where(user: user) }
end