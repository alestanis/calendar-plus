class SessionsController < CalendarController #ApplicationController
  def create
    # Get or create the user
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
    user = User.find(session[:user_id])
    if user
      user.destroy
    end
    session[:user_id] = nil
    session[:token] = nil
    redirect_to root_url, notice: "Signed out!"
  end
end
