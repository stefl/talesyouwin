require 'open-uri'

class Account
  include Mongoid::Document
  attr_accessor :password, :password_confirmation

  # Fields
  field :name,             :type => String
  field :surname,          :type => String
  field :email,            :type => String
  field :crypted_password, :type => String
  field :role,             :type => String
  field :provider,         :type => String
  field :auth
  field :uid
  field :screen_name

  before_save :cache_twitter

  def cache_twitter
    if screen_name.blank?
      json = JSON.parse(open("https://twitter.com/users/#{uid}.json").read)
      self.screen_name = json["screen_name"]
    end
  end

  ##
  # This method is for authentication purpose
  #
  def self.authenticate(email, password)
    account = first(:conditions => { :email => email }) if email.present?
    account && account.has_password?(password) ? account : nil
  end


  def self.create_with_omniauth(auth)
      account = create!(
        provider: auth["provider"],
        uid: auth["uid"],
        name: auth["info"]["name"],
        role: "users"
      )
      account
  end
  ##
  # This method is used by AuthenticationHelper
  #
  def self.find_by_id(id)
    find(id) rescue nil
  end

  def has_password?(password)
    ::BCrypt::Password.new(crypted_password) == password
  end

  private
    def encrypt_password
      self.crypted_password = ::BCrypt::Password.create(self.password)
    end

    def password_required
      crypted_password.blank? || self.password.present?
    end
end
