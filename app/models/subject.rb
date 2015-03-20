class Subject < ActiveRecord::Base
  has_many :subject_lessons
  has_many :exams
  has_many :homeworks
  has_many :lesson_prepares
  has_many :notes
  
  belongs_to :user
  
  validates_presence_of :title
  
  include ApplicationHelper
  
  def self.max=value
    @@max = value
  end
  
  def abbr
    title.mb_chars[0, 3]
  end
  
  def current_prepare
    lesson_prepares.find_by_date(Date.today.to_s) || LessonPrepare.new({:subject => self, :date => Date.today})
  end
  
  def time_total
    time.to_i + time_exams + time_homeworks
  end
  
  def time_exams
    Exam.sum(("length - length_done"), sum_options).to_i
  end
  
  def time_homeworks
    Homework.sum("length - length_done", sum_options).to_i
  end
  
  def time_left
    time_total.to_i - current_prepare.length_done.to_i
  end
  
  def subject_time_left
    time.to_i - current_prepare.length_done.to_i
  end
  
  def importance
    return 0 if @@max == 0
    ((time_left.to_f / @@max) * 10).round
  end
  
  def self.my_subjects user
    find :all, :conditions => ["user_id = ?", user.id]
  end
  
  def time
    super ? super : 0
  end
  
  def done?
    prepare = lesson_prepares(:conditions => ['date = ?', Date.today]).first
    return false unless prepare
    prepare.length_done == self.time
  end
  
  def done!
    prepare = self.current_prepare
    prepare.length_done = self.time
    prepare.save
  end
  
  def revert!
    prepare = self.current_prepare
    prepare.destroy
  end
  
  def color
    super || :blue
  end
  
  def to_s
    title
  end
  
  def average_group
    case average
    when 1...2
      1
    when 2...3
      2
    when 3...4
      3
    when 4...5
      4
    when 5
      5
    end
  end
  
  private
  
  def sum_options
    {:conditions => ["subject_id = ? and `when` = ?", self.id, next_work_date.to_s]}
  end
end
