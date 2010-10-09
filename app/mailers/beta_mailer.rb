class BetaMailer < ActionMailer::Base
  default :from => "beta@graveyardapp.com"
  
  def daily_beta
    mail(:to => 'beta-notify@graveyardapp.com', :subject => "Users registered with Graveyard today..")
  end
end
