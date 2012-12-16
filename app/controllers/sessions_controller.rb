class SessionsController < CalendarController #ApplicationController
  def create
    # Get or create the user
    logger.debug env["omniauth.auth"].to_yaml
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    session[:token] = env["omniauth.auth"]["credentials"]["token"]
 
    # Update data related to the Google Calendars in the user
    update_events
    user.update_attribute(:updated, Time.now)
    
    # Exit
    redirect_to root_url, notice: "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    session[:token] = nil
    redirect_to root_url, notice: "Signed out!"
  end
end