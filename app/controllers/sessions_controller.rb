class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:error] = "Invalid email/password."
      redirect_to login_path
    end
  end #end create method

  def destroy
    session.delete :user_id
    redirect_to login_path
  end

  def welcome
  end

end ## End SessionsController
