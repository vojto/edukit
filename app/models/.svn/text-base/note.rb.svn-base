class Note < ActiveRecord::Base
  belongs_to :subject
  
  after_save :save_average
  after_destroy :save_average
  
  def to_s
    case note
    when 1
      "1"
    when 1.5
      "1-"
    when 2
      "2"
    when 2.5
      "2-"
    when 3
      "3"
    when 3.5
      "3-"
    when 4
      "4"
    when 4.5
      "4-"
    when 5
      "5"
    else
      note
    end
  end
  
  def save_average
    if subject
      if subject.notes.length == 0
        subject.average = nil
        subject.save!
      else  
        subject.average = (subject.notes.sum :note) / subject.notes.length
        subject.save!
      end
    end
  end
end
