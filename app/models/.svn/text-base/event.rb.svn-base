module Event
  def done?
    length_done == length
  end
  
  def when= d
    super(Date.strptime(d, "%d.%m.%Y")) unless d.to_s.empty?
  end
  
  def when_before_type_cast
    Date.parse(super).strftime("%d.%m.%Y") if super.present?
  end
  
  def done!
    self.length_done = self.length
  end
  
  def length
    super || 0
  end
  
  def before_save
    self.length_done ||= 0
    self.length      ||= 0
  end
end