class Homework < ActiveRecord::Base
  belongs_to :subject
  
  validates_presence_of :when, :message => "nesmie byť prázdny"
  
  include Event
end