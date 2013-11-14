class PagesController < CalendarController #ApplicationController  
  def events
    get_info()
    render :index
  end
  
  def index
    get_info()
  end
  
  def tour
    get_info()
    
    @distances = (1..@events.length).map do |i|
      directions = Gmaps4rails.destination({
        "from" => @events[i-1].location,
        "to" => @events[i % @events.length].location
      })
      distance = directions.first["distance"]["text"] # "17.2 mi"
      duration = directions.first["duration"]["text"] # "22 mins"
      { dist: distance, dur: duration }
    end if @events.length > 1
  end
  
  def get_info
    if current_user
      @calendars = get_calendars
      @calendar = @calendars.first.id if @calendars.first
      
      # Get today's events
      update_events
      @events = current_user.events.today
      
      # Get the markers to display in the map
      @markers = @events.map do |e|
        { lat: e.to_coordinates[0], lng: e.to_coordinates[1] }
      end
      @marker_coords = @events.map do |e|
        e.to_coordinates.join(',')
      end
      
      # If empty, send the user to its local Calendar timezone
      if @markers.length == 0
        
      end
    end
  end
end
