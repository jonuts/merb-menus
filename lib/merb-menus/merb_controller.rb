class Merb::Controller
  before do; Merb::Menus.reset! end

  def self.create_menu(name, &data)
    Merb::Menus::Menu.new(name).instance_eval &data
  end

  def get_submenu(top, sub)
    top.submenus.find {|m| m.name.to_s == sub.to_s}
  end

  def get_item(submenu, item)
    submenu.items.find {|e| e.name.to_s == item.to_s}
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

    @__menu_generated__ = true
  end

  def menu_generated?
    !!@__menu_generated__
  end

  private

  def no_menu!
    @__no_menu__ = true
  end

  def no_menu?
    !!@__no_menu__
  end

  def generate_default_menu
    return if no_menu? || menu_generated?

    if top = Merb::Menus.current_menu = Merb::Menus.default
      generate_menu(top)

      if menu = top.current_submenu = get_submenu(top, controller_name)
        menu.current_item = get_item(menu, action_name)
      end
    end
  end
end

