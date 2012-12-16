class Event
  include Mongoid::Document
  # include Mongoid::Geo
  include Geocoder::Model::Mongoid
  include Gmaps4rails::ActsAsGmappable
  
  # https://developers.google.com/google-apps/calendar/v3/reference/events
  
  field :g_id, type: String
  field :summary, type: String
  field :description, type: String
  field :start, type: DateTime
  field :end, type: DateTime
  field :location, type: String
  field :coordinates, :type => Array#, :geo => true, :lat => :latitude, :lng => :longitude
  
  embedded_in :user
  
  validates_presence_of :g_id
  validates_uniqueness_of :g_id
  
  # geo_index :location
  geocoded_by :location
  after_validation :geocode
  acts_as_gmappable :position => :coordinates, :process_geocoding => false
  
  scope :today, where(:start.gte => Date.today, :start.lt => Date.today + 1.day)
  scope :tomorrow, where(:start.gte => Date.today + 1.day, :start.lt => Date.today + 2.days)
 
  def gmaps4rails_address
    self.location
  end
end