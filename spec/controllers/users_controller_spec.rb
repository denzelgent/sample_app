require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'show'" do
    
    before(:each) do
      @user = Factory(:user)
    end
    
    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end
    
    it "should ge the right user" do
         get :show, :id => @user
        assigns(:user).should == @user
   end
   
   it "should have the right title" do
     get :show, :id => @user
     response.should have_selector('title', :content => @user.name)
   end
   
   it "should have the users name" do
     get :show, :id => @user
     response.should have_selector('h1', :content => @user.name)
   end
   
   it "should have a profile image" do
    get :show, :id => @user
    response.should have_selector('h1>img', :class => "gravatar")
   end
   
   it "should have the right URL" do
      get :show, :id => @user
      response.should have_selector('td>a', :content => user_path(@user),
                                           :href    => user_path(@user))
   
  end
end
  
  
  describe "GET 'new'" do
    
    it "should be successful" do
      get :new
      response.should be_success
    end
    it "should have the right title" do 
      get :new  
      response.should have_selector("title", :content => "Sign up")
        end 
      end
      
      describe "POST 'CREATE'" do
        decribe "failure" do
          before(:each) do
            @attr={:name =>"", :email => "", :password => ""
                  :password_confirmation =>""}
          end
          
          it "should have the right title" do
            post :create, :user => @attr
            response.should have_selector('title', :content => "Sign Up")
          end
          
          it "should render the 'new' page" do
            post :create, :user => @attr
            response.should render_template('new')
          end
          
          it "should not create a user"
          
        end
          
      
    end

