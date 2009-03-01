### MerbAuthRememberMe

This plugin provides a remember me strategy for Merb Auth. The original plugin was built by Pun Neng (http://github.com/PunNeng/).

The plugin also provides some Merb::Authentication.user_class mixins to keep the models fat and the strategy code thin. The mixins are added to the user class by default. If you choose not to include these and would rather roll your own set the plugin configuration in your config/init.rb file like so:
<pre><code>
  Merb::Plugins.config[:merb_auth_remember_me][:include_model_methods] = false
</code></pre>

This plugin automatically registers and activates the remember_me strategy with Merb Auth, so no additional configuration is necessary.

### Migration Requirements

The plugin requires some fields your user authentication model. Right now there is ORM specific inclusions for Datamapper. The Sequel one needs to be built and a migration needs to be made for ActiveRecord. No migration generators are included but the plugin requires the following fields
<pre><code>  
  DateTime  :remember_token_expires_at
  String    :remember_token
</code></pre>

------------------------------------------------------------------------------  

### Instructions for installation:

# Add the plugin as a regular dependency in your dependency.rb file

    dependency 'rughetto-merb-auth-remember-me', :require_as => 'merb-auth-remember-me'

# To clear the :auth\_token after log out

Unpack the merb-auth-password application code if it hasn't been done already:
<pre><code>
  bin/rake slices:merb-auth-slice-password:freeze  
</code></pre>    
   
Change the #destroy method in slices/merb-auth-slice-password/app/controllers/session_override.rb to include     
<pre><code>
  cookies.delete :auth_token
</code></pre>
    
# Add the right form inputs into your unauthenticated.html.erb (login) page 

  <input type="checkbox" id="remember_me" name="remember_me" value="1">

