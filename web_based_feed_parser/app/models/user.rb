class User < ActiveRecord::Base
  validates_presence_of :name  ,:message=>"Name can not be empty"
  validates_presence_of :mobile,:message=>"Mobile Number can not be empty"
  validates_presence_of :email,:message=>"Email can not be empty"
  validates_presence_of :user_name,:message=>"User Name can not be empty"
  validates_uniqueness_of :user_name,:email,:mobile
  attr_accessor :password,:cpassword
  has_many :user_rss_types
  
  
  def self.login(user_name, password, salt)
    hashed_password = hash_password(password || "",salt)
    find(:first,:conditions => ["user_name = ? and encrypt_password = ?", user_name, hashed_password])
  end
  
  def try_to_login
    salt=""
    login=User.find_by_user_name(self.user_name)
    salt=login.salt if login.inspect != "nil"
    User.login(self.user_name, self.password, salt)
  end
  
  private
  def self.hash_password(password,salt=nil)
    return if password.blank?
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end
end
