class Timetable
  def initialize lesson_set
    @lesson_set = Hash[]
    lesson_set.each do |array_item|
      @lesson_set["#{array_item.day}_#{array_item.lesson}"] = array_item;
    end
  end
  
  def send method
    if /=$/ ==  method then
      raise Exception.new( 'Setters are not allowed here.' )
    else
      value = @lesson_set[method]
      value.subject_id if value
    end
  end
  
  def update data
    data.each do |index, value|
      if @lesson_set[index] then
        @lesson_set[index].subject_id = value
        @lesson_set[index].save
      else
        lesson_subject = LessonSubject.new
        (day, lesson) = index.split('_')
        lesson_subject.day = day
        lesson_subject.lesson = lesson
        lesson_subject.subject_id = value
        lesson_subject.save
      end
    end
  end
end