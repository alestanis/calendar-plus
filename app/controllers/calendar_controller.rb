class CalendarController < ApplicationController

  def get_calendars
    if api_client
      api_client.execute(
        :api_method => api_service.calendar_list.list,
        :parameters => {},
        :headers => {'Content-Type' => 'application/json'}).data.items
    end
  end
  
  def get_updated_events
    if api_client      
      api_client.execute(
        :api_method => api_service.events.list,
        :parameters => {
          'calendarId' => 'primary',
          'orderBy' => 'startTime',
          'singleEvents' => true,
          'updatedMin' => current_user.updated.strftime("%Y-%m-%dT00:00:00Z"),
          'timeMin' => (Time.now - 1.day).strftime("%Y-%m-%dT00:00:00Z"), #'2012-11-23T10:41:09.000Z',
          'timeMax' => (Time.now + 1.month).strftime("%Y-%m-%dT00:00:00Z") #'2012-11-23T10:41:09.000Z'
        }).data.items
    end
  end
  
  # Add updated events to the user local model
  def update_events
    # TODO: handle simple "date" in "all day" events
    # TODO: handle deletions
    google_updated_events = get_updated_events
    if google_updated_events.length > 0
      google_updated_events.each do |event|
        new_event = current_user.events.find_or_create_by(g_id: event.id)
        new_event.update_attributes!({
          'g_id' => event.id,
          'summary' => event.summary,
          'description' => event.description,
          'start' => event.start["dateTime"],
          'end' => event.end["dateTime"],
          'location' => event.location
        })
      end
    end
  end
end