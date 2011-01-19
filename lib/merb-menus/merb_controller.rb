class Merb::Controller
  before do; Merb::Menus.reset! end
  before :generate_default_menu

  class << self
    def create_menu(name, &data)
      Merb::Menus::Menu.new(name).instance_eval &data
    end

    # ==== Parameters
    # top<Merb::Menus::Menu>::
    # sub<Symbol>:: name of desired submenu
    def get_submenu(top, sub)
      top.submenus.find {|m| m.name.to_s == sub.to_s}
    end

    # ==== Parameters
    # menu<Merb::Menus::Submenu>::
    # item<Symbol>:: name of desired item
    def get_item(menu, item)
      item = menu.items.find{|e| e.name.to_s == item.to_s}
    end
  end

  def get_submenu(top, sub)
    self.class.get_submenu(top, sub)
  end

  def get_item(menu, item)
    self.class.get_item(menu, item)
  end

  def menu_item(*args)
    menu, submenu, item = *args

    if item.nil?
      item = submenu
      submenu = menu
      menu = Merb::Menus.default.name
    end

    top = Merb::Menus[menu]
    Merb::Menus.current_menu = top
    generate_menu(top)
    submenu = get_submenu(top, submenu)
    top.current_submenu = submenu
    submenu.current_item = get_item(submenu, item)
  end

  def current_menu
    Merb::Menus.current_menu
  end

  def current_submenu
    Merb::Menus.current_submenu
  end

  def current_item
    Merb::Menus.current_item
  end

  # Generate items in the context of our current controller instance
  # so that we can generate urls with merb's url helpers
  def item(*args)
    @__submenu_generation__.item(*args)
  end

  def generate_menu(menu)
    menu.submenus.each do |m|
      @__submenu_generation__ = m
      instance_eval &m.data
      m.generated!
    end
  end

  private

  def generate_default_menu
    if top = Merb::Menus.current_menu = Merb::Menus.default
      generate_menu(top)

      if menu = top.current_submenu = get_submenu(top, controller_name)
        menu.current_item = get_item(menu, action_name)
      end
    end
  end
end

