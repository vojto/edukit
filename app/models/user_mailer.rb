class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Tvoje konto je vytvorené. Teraz si ho aktivuj.'
  
    @body[:url]  = "http://www.edukit.sk/aktivacia/#{user.activation_code}"
  
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Tvoje konto bolo aktivované!'
    @body[:url]  = "http://www.edukit.sk/"
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "oracle@edukit.sk"
      @subject     = "Edukit: "
      @sent_on     = Time.now
      @body[:user] = user
    end
end
