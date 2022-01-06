class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with :name => ENV['BASIC_AUTH_ACC'], :password => ENV['BASIC_AUTH_PW']
  
  def show
  end
end
