class SubjectLesson < ActiveRecord::Base
  belongs_to :subject
  
  def self.timetable user_id
    lessons = SubjectLesson.find(:all, :joins => :subject, :conditions => ["subjects.user_id = ?", user_id])
    Timetable.new lessons
  end
  
  def self.current user_id
    day = Date.today.next.wday.to_i
    day = 1 if (day==6 || day==0)
    lessons = SubjectLesson.find :all, :select => "*, count(subject_lessons.id) AS subject_lessons_count", :joins => :subject, :conditions => ["day = ? AND subjects.user_id=?", day, user_id], :group => 'subject_id, subject_lessons.id'
    begin
      Subject.max = lessons.sort_by { |i| i.subject ? i.subject.time_left.to_i : 0 }.reverse.first.subject.time_left
    rescue
      []
    end
    lessons.map { |lesson| lesson.subject if lesson.subject }
  end
end