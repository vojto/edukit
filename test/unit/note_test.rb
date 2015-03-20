require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "should count average upon creating a note" do
    subject = Subject.new({ :title => "Just a subject!" })
    subject.save!
    
    notes   = [1, 2, 2.5, 2, 3]
    notes.each do |note|
      n = Note.new
      n.note = note
      n.subject_id = subject.id
      n.save!
    end
    
    subject.reload
                
    avg = (notes.sum{ |n| n }) / notes.length
    
    assert_equal subject.average, avg, "The subject average should be #{avg} but was #{subject.average}"
  end
end
