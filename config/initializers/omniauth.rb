# Send the OmniAuth output to the Rails logger
OmniAuth.config.logger = Rails.logger

if Rails.env.development?

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "103165630226.apps.googleusercontent.com", "HahK058uK2jszSW3JxR8Vwxi", {
    access_type: 'offline',
    scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/calendar',
    redirect_uri:'http://localhost:3000/auth/google_oauth2/callback'
  }
end

else

Rails.application.config.middleware.use OmniAuth::Builder do
   provider :google_oauth2, "103165630226.apps.googleusercontent.com", "HahK058uK2jszSW3JxR8Vwxi", {
    access_type: 'offline',
    scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/calendar',
    redirect_uri:'http://calendar-plus.herokuapp.com/auth/google_oauth2/callback'
   }
end  
  
end
