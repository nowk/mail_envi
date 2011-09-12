class UserMailer < ActionMailer::Base
  default :from => "default@company.com"

  def registration_complete(user)
    @user = user
    mail(:to => @user.email, 
         :subject => "Your registration has been completed") do |format|
      format.html { render :text => "Hello World!" }
      format.text { render :text => "Hello World!" }
    end
  end
end
