if defined?(Merb::Plugins)
  $:.unshift File.dirname(__FILE__)

  # register the authentication strategy
  require(File.expand_path(File.dirname(__FILE__) / "merb-auth-remember-me" / "mixins") / "authenticated_user")
  strategy_path = File.expand_path(File.dirname(__FILE__)) / "merb-auth-remember-me" / "strategies"
  Merb.logger.info('Registering and activating RememberMe strategy')
  Merb::Authentication.register(:remember_me, strategy_path / "remember_me.rb")
  Merb::Authentication.activate!(:remember_me) # and activate it
  
  # Plugin configurations
  Merb::Plugins.config[:merb_auth_remember_me] = {:include_model_methods => true }
  
  Merb::BootLoader.after_app_loads do
    Merb::Authentication.after_authentication do |user,request,params|
      if params[:remember_me] == "1" 
        user.remember_me
        request.cookies.set_cookie(
          :auth_token, 
          user.remember_token, 
          :expires => user.remember_token_expires_at.to_time
        )
      end
      user 
    end # Merb::Authentication.after_authentication
    
    Merb::Authentication.user_class.class_eval do
      if Merb::Plugins.config[:merb_auth_remember_me][:include_model_methods]
        Merb.logger.info("Including RememberMe Mixin in #{Merb::Authentication.user_class}. 
        To avoid this inclusion add 'Merb::Plugins.config[:merb_auth_remember_me][:include_model_methods] = false' in your config/init.rb before_app_loads method")
        include Merb::Authentication::Mixins::AuthenticatedUser
      end  
    end # Merb::Authentication.user_class.class_eval
  end # Merb::BootLoader.after_app_loads
end # if defined?(Merb::Plugins)
