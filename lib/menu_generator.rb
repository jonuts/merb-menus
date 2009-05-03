# make sure we're running inside Merb
if defined?(Merb::Plugins)
  # Merb gives you a Merb::Plugins.config hash...feel free to put your stuff in your piece of it
  Merb::Plugins.config[:menu_generator] = {
    :chickens => false
  }

  Merb::BootLoader.before_app_loads do
    Application.class_eval do
      include MainMenuMixin

      class << self; attr_reader :submenus, :current_menu; end

      @submenus ||= []
    end
  end
  
  Merb::BootLoader.after_app_loads do
    # code that can be required after the application loads
  end
  
  Merb::Plugins.add_rakefiles "menu_generator/merbtasks"
end
