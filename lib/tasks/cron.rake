desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  unless BetaInterest.created_today.empty?
    BetaMailer.daily_beta.deliver
  end
end
