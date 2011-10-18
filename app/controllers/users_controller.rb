class UsersController < ApplicationController
  
  def show 
     @user = User.find(params[:id])
     @title = @user.name + "<script>"
   end
  
  def new 
    @user = User.new
    @title = "Sign up"    
  end 
  
  def create
    @user = User.new
    render 'new'
  end
  
 
  
  
  
end
