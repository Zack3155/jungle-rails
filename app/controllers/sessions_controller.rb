class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      session[:user_id] = user.id
      redirect_to '/', notice: 'User logined!'
    else
      redirect_to '/login', notice: 'Please try again!'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login', notice: 'User logout!'
  end

end
