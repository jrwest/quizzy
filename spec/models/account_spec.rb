require 'spec_helper'
require 'account'

describe Account do
  let(:valid_attributes) { {:name => "accountname", :password => "mypassword", :confirm_password => "mypassword" } }
  it "can be created with valid attributes" do
    Account.create(valid_attributes)
  end
  it "does not store an empty password hash" do
    Account.create(valid_attributes)
    Account.where(:name => "accountname").first.password_hash.should_not be_nil
  end
  it "doesnt not store password hash in plain text" do
    Account.create(valid_attributes)
    Account.where(:name => "accountname").first.password_hash.should_not == "mypassword"
  end
  it "does not store the plain text password field" do
    Account.create(valid_attributes)
    Account.where(:name => "accountname").first.password.should be_nil
  end
  it "does not store the confirm password field" do
    a = Account.create(:name => "accountname", :password => "mypassword", :confirm_password => "mypassword")
    Account.where(:name => "accountname").first.confirm_password.should be_nil
  end
  it "should not be valid with an empty account name" do
    Account.new(:name => "", :password => "mypassword", :confirm_password => "mypassword").should_not be_valid
  end
  it "should not be valid with an account name that contains invalid charaters" do
    invalid_account_names = ['with spaces', 
                             'witha/', 
                             'witha:', 
                             'witha-', 
                             'witha.', 
                             'witha@', 
                             'witha!', 
                             'witha#', 
                             'witha$', 
                             'witha%', 
                             'witha&',
                             'witha*',
                             'witha(',
                             'witha)']
    invalid_account_names.each do |account_name|
      Account.new(:name => account_name, :password => "mypassword", :confirm_password => "mypassword").should_not be_valid
    end
  end
  it "should not be valid with an empty password" do
    Account.new(:name => "myaccount", :password => "", :confirm_password => "").should_not be_valid
  end
  it "should be valid if an existing records password is set to the empty string" do
    Account.create(:name => "myaccount", :password => "mypassword", :confirm_password => "mypassword")
    a = Account.first(:conditions => {:name => "myaccount"})
    a.password = ""
    a.should_not be_valid
  end
  it "cannot be created with non-matching passwords" do
    Account.new(:name => "myaccount", :password => "abc", :password => "def").should_not be_valid
  end
end
