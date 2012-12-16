require 'rubygems'
require 'google/api_client'

class User
  include Mongoid::Document
  
  field :provider, type: String
  field :uid, type: String
  field :name, type: String
  field :token, type: String
  field :updated, type: DateTime, default: Time.now - 7.days
  
  embeds_many :events

  # Omniauth-related
  def self.from_omniauth(auth)
    puts "---- auth : " + auth.to_json
    puts "---- slice : " + auth.slice("provider", "uid").to_json
    puts "---- where : " + where(auth.slice("provider", "uid")).to_json
    user = where(auth.slice("provider", "uid")).first
    puts "---- user : " + user.to_json
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
    end
  end
end