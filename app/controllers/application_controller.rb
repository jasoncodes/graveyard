class ApplicationController < ActionController::Base
  protect_from_forgery
  analytical :modules => [:google], :use_session_store => true
end
