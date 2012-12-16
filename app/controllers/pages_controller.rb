class PagesController < CalendarController #ApplicationController  
  def index
    if current_user
      @calendars = get_calendars
      @calendar = @calendars.first.id
      
      # Get today's events
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