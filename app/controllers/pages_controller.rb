class PagesController < ApplicationController
  def home
    @title = "Home"
    @message = "You are at the Title Page"
  end

  def contact
    @title = "Contact"
  end
  
  def about
    @title = "About"
  end

end
