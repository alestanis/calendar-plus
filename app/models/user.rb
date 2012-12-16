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
    puts "Inside from Omniauth"
    puts auth.to_yaml
    user = where(auth.slice("provider", "uid")).first
    puts "User id = #{user._id}" if user
    if user
      user.token = auth["credentials"]["token"]
      puts "User Token = #{user.token}"
      user
    else
      create_from_omniauth(auth)
    end
    puts "Leaving from Omniauth"
  end

  def self.create_from_omniauth(auth)
    puts "Create from Omniauth"
    create! do |user|
      puts "With Provider = #{auth["provider"]}"
      user.provider = auth["provider"]
      puts "With Uid = #{auth["uid"]}"
      user.uid = auth["uid"] # Email for google
      puts "With Name = #{auth["uid"].split('@')[0]}"
      user.name = auth["uid"].split('@')[0] # Login of gmail account, "user" in "user@gmail.com"
      # user.token = auth["credentials"]["token"]
      puts "Leaving Create from Omniauth"
    end
  end
end