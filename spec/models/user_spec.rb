require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = {:email => "incorvia@gmail.com", :password => "foobar", :password_confirmation => "foobar"}
  end
  
  it "should create a valid instance given @attr" do
    User.create!(@attr)
  end
  
  describe "Email Validations" do         #  -----  Email Validations -----
    
    it "should require presence of an Email Address" do
      user = User.new(@attr.merge(:email => ""))
      user.should_not be_valid
    end
    
    it "should accept valid email addressses" do
      addresses = %w[user@foo.bar a+f_a.foo@ba.or.edu FOOBAR@au.jp]
      addresses.each do |address|
        valid_email_user = User.new(@attr.merge(:email => address))
        valid_email_user.should be_valid
      end
    end
    
    it "should reject invalid email addresses" do
      addresses = %w[user@foo. user.foo.org user@use,co]
      addresses.each do |address|
        invalid_email_user = User.new(@attr.merge(:email => address))
        invalid_email_user.should_not be_valid 
      end
    end
    
    it "should reject non-unique email addresses" do
      User.create!(@attr)
      non_unique_user = User.new(@attr)
      non_unique_user.should_not be_valid
    end
    
    it "should reject case-insensitive duplicates" do
      User.create!(@attr)
      upcase = @attr[:email].upcase
      non_unique_user = User.new(@attr.merge( :email => upcase ))
    end
  end 
    
  describe "Password Validations" do         #  -----  Password Validations -----
      
    it "should require a password" do
      blank_password_user = User.new(@attr.merge(:password => ""))
      blank_password_user.should_not be_valid
    end  
    
    it "should take a mininum of 6 characters" do
      short = "a" * 5
      short_pass_user = User.new(@attr.merge(:password => short, :password_confirmation => short))
      short_pass_user.should_not be_valid
    end
    
    it "should take a maximum of 40 characters" do
      long = "a" * 41
      long_pass_user = User.new(@attr.merge(:password => long, :password_confirmation => long))
      long_pass_user.should_not be_valid
    end
    
    it "should require matching passwords" do
      mismatch_pass_user = User.new(@attr.merge(:password_confirmation => "invalid"))
      mismatch_pass_user.should_not be_valid
    end  
  end  
  
  describe "Encryption Validations" do         #  -----  Encryption Validations -----
  
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should have an encrypted password" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "should set an encrypted password" do
      @user.encrypted_password.should_not be_blank
    end
    
    describe "has_password? method" do        #  -----  Has_Password -----
    
      it "should return true if passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end
      
      it "should return false if passwords don't match" do
        @user.has_password?("invalid").should be_false
      end
    end
    
    describe "authenticate method" do              #  -----  Authentication -----
      
      it "should return nil if email doesn't exist" do
        wrong_email_user = User.authenticate("abc@test.com", @attr[:password])
        wrong_email_user.should be_nil
      end
      
      it "should return nil if password doesn't match" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil
      end
      
      it "should return user object if password / email match" do
        valid_user = User.authenticate(@attr[:email], @attr[:password])
        valid_user.should == @user
      end
      
    end
  end

  describe "notecard associations" do

    before(:each) do
      @user = User.create(@attr)
      @note1 = Factory(:notecard, :user => @user, :created_at => 1.day.ago)
      @note2 = Factory(:notecard, :user => @user, :created_at => 1.hour.ago)

    end

    it "should respond to notecard attribute" do
      @user.should respond_to(:notecards)
    end

    it "should have the correct post order" do
      @user.notecards.should == [@note2, @note1]
    end

    it "should delete dependents" do
      @user.destroy
      [@note1, @note2].each do |note|
        Notecard.find_by_id(note.id).should be_nil
      end
    end
  end
end
