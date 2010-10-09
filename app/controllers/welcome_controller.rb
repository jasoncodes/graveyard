class WelcomeController < ApplicationController
  def register_interest
    begin
      BetaInterest.create! :email => params[:beta_interest][:email]
      message = 'Thank you for registering your interest in Graveyard.'
    rescue ActiveRecord::RecordInvalid => e
      error = 'This email has already been registered with Graveyard. Please try another address.'
    end

    respond_to do |format|
      unless error
        format.html { flash[:notice] = message and redirect_to root_path }
      else
        format.html { flash[:alert] = error and redirect_to root_path}
      end
    end
  end
end
