# make sure we're running inside Merb
if defined?(Merb::Plugins)

  $:.unshift File.dirname(__FILE__)

  # register the authentication strategy
  require(File.expand_path(File.dirname(__FILE__) / "merb-auth-remember-me" / "mixins") / "authenticated_user")
  strategy_path = File.expand_path(File.dirname(__FILE__)) / "merb-auth-remember-me" / "strategies"
  Merb::Authentication.register(:remember_me, strategy_path / "remember_me.rb")
  
  # Plugin configurations
  Merb::Plugins.config[:merb_auth_remember_me] = { }
  
  Merb::BootLoader.before_app_loads do
  end
  
  Merb::BootLoader.after_app_loads do
    Merb::Authentication.after_authentication do |user,request,params|
      if params[:remember_me] == "1" 
        user.remember_me
        request.cookies.set_cookie(:auth_token, user.remember_token, :expires => user.remember_token_expires_at.to_time)
      end
      user 
    end
  end
  
end
