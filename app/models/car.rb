class Event < ActiveRecord::Base
  belongs_to :user
  
  validates :content, presence: true
end