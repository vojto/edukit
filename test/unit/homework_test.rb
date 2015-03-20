require 'test_helper'

class HomeworkTest < ActiveSupport::TestCase  
  # Replace this with your real tests.
  test "should not create homework without date" do
    homework = Homework.new
    homework.save
    
    assert !homework.valid?
  end
  
  test "should set as done" do
    homework = homeworks(:one)
    homework.done!
    homework.save
    
    assert homework.length == homework.length_done, "After setting a homework as done it should have equal length and length done!"
  end
  
  test "sholud automatically set length_done to zero" do
    homework = Homework.new(:when => I18n.l(Date.today))
    homework.length = 40   
    homework.save 
    
    assert homework.length_done == 0, "Newly created homework should have length_done eq to zero!"
  end
end
