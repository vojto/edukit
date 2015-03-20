require 'digest/sha1'
class User < ActiveRecord::Base
  # Virtual attribute for the unencrypted password
  attr_accessor :password
  
  has_many :subjects

  validates_presence_of     :login, :email, :message => "musíš vyplniť"
  validates_presence_of     :password, :password_confirmation, :message => "musíš vyplniť", :if => :new_record?
  validates_confirmation_of :password, :message => "sa nezhoduje s potvrdením"
  validates_length_of       :login,    :within => 3..40, :too_short => "je príliš krátke", :too_long => "je príliš dlhé"
  validates_length_of       :email,    :within => 3..100, :too_short => "je príliš krátke", :too_long => "je príliš dlhé"
  validates_uniqueness_of   :login, :case_sensitive => false, :message => "je už použité, skús nejaké iné"
  validates_uniqueness_of   :email, :case_sensitive => false, :message => "je už použitý, skús sa prihlásiť"
  before_save :encrypt_password
  before_create :make_activation_code 
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :password, :password_confirmation
  
  def self.create_login login
    if self.find_by_login login
      "#{login}-1"
    else
      login
    end
  end
  
  def notes
    notes = Note.find :all, :joins => :subject, :conditions => ["subjects.user_id = ?", self.id]
    subjects = {}
    self.subjects.each do |subject|
      subjects[subject] = []
    end
    notes.each do |note|
      subjects[note.subject] << note
    end
    
    subjects.sort_by{|s,ns|s.average||0}.reverse
  end
  
  def subject_lessons
    SubjectLesson.find :all, :joins => :subject, :readonly => false, :conditions => ["subjects.user_id = ?", self.id]
  end
  
  def subject_lessons_hash
    lessons = subject_lessons
    Hash[*lessons.map do |i|
      ["#{i.day}_#{i.lesson}", i]
    end.flatten]
  end
  
  def active_homeworks day = nil
    homeworks = Homework.find :all, :joins => :subject, :conditions => ["subjects.user_id = ? and homeworks.when >= ?", self.id, Date.today]
    if day
      return homeworks.select { |h| h.when == day }
    else
      return homeworks
    end
  end
  
  def active_exams day = nil
    exams = Exam.find :all, :joins => :subject, :conditions => ["subjects.user_id = ? and exams.when >= ?", self.id, Date.today]
    if day
      return exams.select { |e| e.when == day }
    else
      return exams
    end
  end

  # Activates the user in the database.
  def activate
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    save(false)
  end

  def active?
    # the existence of an activation code means they have not activated yet
    activation_code.nil?
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    u = find :first, :conditions => ['login = ? and activated_at IS NOT NULL', login] # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    remember_me_for 2.weeks
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    self.remember_token_expires_at = time
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  protected
    # before filter 
    def encrypt_password
      return if password.blank?
      self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
      self.crypted_password = encrypt(password)
    end
      
    def password_required?
      crypted_password.blank? || !password.blank?
    end
    
    def make_activation_code

      self.activation_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
    end
    
end
