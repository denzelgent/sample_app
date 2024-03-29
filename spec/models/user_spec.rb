require 'spec_helper' 

# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#
describe User do
  
  before(:each) do
    @attr ={ :name => "Example User", 
             :email => "user@example.com",
             :password => "foobar",
             :password_confirmation => "foobar"
             
             }
  end

  
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end
  
  it "should require a name" do
    no_name_user = User.new(:email => "user@example.com")
    no_name_user.should_not be_valid 
  end
  
  it "should require an email address" do
    no_email_user = User.new(:name => "Example User")
    no_email_user.should_not be_valid
  end
  
  it "should reject names that are too long" do 
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end
  
  it "should accept valide email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@fo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email =>address))
      valid_email_user.should be_valid
    end
end

 it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.] 
    addresses.each do |address|
       invalid_email_user = User.new(@attr.merge(:email => address))
       invalid_email_user.should_not be_valid
      end 
    end
    
    it "should reject deuplicate email addresses" do
      User.create!(@attr)
      user_with_duplicate_email = User.new(@attr)
      user_with_duplicate_email.should_not be_valid
    end
    
    it "should reject email addresses identical up to case" do
        upcased_email = @attr[:email].upcase
        User.create!(@attr.merge(:email => upcased_email))
        user_with_duplicate_email = User.new(@attr)
        user_with_duplicate_email.should_not be_valid
    end 
    
    describe "password" do
    
    before(:each) do
      @user = User.new(@attr)
    end
    
      it "should have a passwor dattribute" do
        User.new(@attr).should respond_to(:password)
      end
      
      it "should have a password confirmation atttribute" do
        @user.should respond_to(:password_confirmation)
      end
  end
    
    describe "password validations" do
      
      it "should require a password" do
        User.new(@attr.merge(:password=>"", :password_confirmation=>"")).
        should_not be_valid
  end
  
    it "should require a matching password confirmation" do
       User.new(@attr.merge(:password_confirmation =>"invalid" )).
       should_not be_valid
     end
     
     it "should reject short passwords" do
       short = "a" * 5
       hash = @attr.merge(:password => short, :password_confirmation => short) 
       User.new(hash).should_not be_valid
     end
     
     it "should reject long passwords" do
       long = "a" * 41
       hash = @attr.merge(:password => long, :password_confirmation => long) 
       User.new(hash).should_not be_valid
     end 
    end
    
   
    describe "password encryption" do
    
      before(:each) do
        @user = User.create!(@attr)
      end
    
      it "should have an encrypted password attribute" do 
        @user.should respond_to(:encrypted_password)
        end 
        
        it "should have a salt" do
          @user.should respond_to(:salt)
        end
        
      it "should set the ecrypted password attribute" do 
        @user.encrypted_password.should_not be_blank
      end
      

      
      describe "has_password? method" do
        
      it "should exist" do
        @user.should respond_to(:has_password?)
        end
         
        
      it "should be true if the passwords match" do 
        @user.has_password?(@attr[:password]).should be_true
      end
      
      it "should be false if the passwords don't match" do 
        @user.has_password?("invalid").should be_false
      end
    end
        
        describe "authentication model" do
        
        it "should exist" do
          User.should respond_to(:authenticate)  
        end
          
        it "should return nil on email/password mismatch" do
          User.authenticate(@attr[:email],"wrongpass").should be_nil
        end
        
        it "should return nil for an email with no user" do
          User.authenticate("bar@foo.com", @attr[:password]).should be_nil
        end
        
        it "should return the user an email/password match" do
          User.authenticate(@attr[:email], @attr[:password]).should == @user
        end
      end
          describe "sign in/out" do
                
              describe "failure" do
                
              it "should not sign a user in" do
                      visit signin_path
                      fill_in :email,    :with => ""
                      fill_in :password, :with => ""
                      click_button
                      response.should have_selector("div.flash.error", :content => "Invalid")
                    end 
              end
              describe "success" do
              it "should sign a user in and out" do
                      user = Factory(:user)
                      visit signin_path
                      fill_in :email,    :with => user.email
                      fill_in :password, :with => user.password
                      click_button
                      controller.should be_signed_in
                      click_link "Sign out"
                      controller.should_not be_signed_in
                    end 
                 end
               end     
          end
   end
  
# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean         default(FALSE)
#

