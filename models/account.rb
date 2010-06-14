class Account
  include Mongoid::Document

  attr_accessor :password, :confirm_password
  
  field :name
  field :password_hash
  field :password_salt

  before_save :prepare_password

  validates_presence_of :name
  validates_format_of :name, :with => /^[a-z]+$/i
  validate :check_password

  
  def password_matches?(pass)
    self.password_hash == encrypt_password(pass)
  end

  def self.authorize(username, password)
    account = first(:conditions => {:name => username})
    return account if account && account.password_matches?(password)
  end

  private 

    def check_password
      if new_record?
        errors.add(:base, "Password cannot be blank") if self.password.blank?
        errors.add(:base, "Passwords do not match") if self.password != self.confirm_password
      else
        errors.add(:base, "Password cannot be blanks") if self.password.blank?
      end
    end

    def prepare_password
      unless password.blank?
        self.password_salt = Digest::SHA1.hexdigest([Time.now, rand].join)
        self.password_hash = encrypt_password(password)
      end
    end

    def encrypt_password(pass)
      Digest::SHA1.hexdigest([pass, password_salt].join) 
    end
end
