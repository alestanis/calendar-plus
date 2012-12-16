require 'rubygems'
require 'google/api_client'

class User
  include Mongoid::Document
  
  before_create :dump_before
  after_create :dump_after
  
  field :provider, type: String
  field :uid, type: String
  field :name, type: String
  field :token, type: String
  field :updated, type: DateTime, default: Time.now - 7.days
  
  embeds_many :events
  
  def dump_before
     puts "Before create User Event"
  end
  
  def dump_after
     puts "After create User Event"
  end
  
  # Omniauth-related
  def self.from_omniauth(auth)
    user = where(auth.slice("provider", "uid")).first
    if user
      user.token = auth["credentials"]["token"]
      user
    else
      create_from_omniauth(auth)
    end
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"] # Email for google
      user.name = auth["uid"].split('@')[0] # Login of gmail account, "user" in "user@gmail.com"
      # user.token = auth["credentials"]["token"]
    end
  end
end