class Merb::Controller
  before do
    controller = params[:controller]
    action = params[:action]

    if top = Merb::Menus.current_menu = Merb::Menus.default
      if menu = top.current_submenu = get_submenu(top,controller)
        menu.current_item = get_item(menu,action)
      end
    end
  end

  def self.create_menu(name, &blk)
    Merb::Menus::Menu.new(name).instance_eval(&blk)
  end

  def self.use_menu(*args)
    menu, submenu = *args
    top = Merb::Menus[menu]
    Merb::Menus.current_menu = top
    raise NoMenuError.new("Menu '#{menu}' does not exist") unless top

    if submenu
      top.current_submenu = get_submenu(top, submenu)
      raise NoMenuError.new("Menu '#{submenu}' does not exist") unless top.current_submenu
    end
  end

  # ==== Parameters
  # top<Merb::Menus::Menu>::
  # sub<Symbol>:: name of desired submenu
  def self.get_submenu(top, sub)
    top.submenus.find {|m| m.name.to_s == sub.to_s}
  end

  # ==== Parameters
  # menu<Merb::Menus::Submenu>::
  # item<Symbol>:: name of desired item
  def self.get_item(menu, item)
    menu.items.find{|e| e.name.to_s == item.to_s}
  end

  def get_submenu(top, sub)
    self.class.get_submenu(top, sub)
  end

  def get_item(menu, item)
    self.class.get_item(menu, item)
  end

  def menu_item(*args)
    case args.size
    when 3
      menu, submenu, item = *args
      self.class.use_menu(menu, submenu)
      top = Merb::Menus[menu]
      menu = get_submenu(top,submenu)
      menu.current_item = get_item(menu,item)
    when 2
      submenu, item = *args
      top = Merb::Menus.default
      self.class.use_menu(top.name,submenu)
      menu = get_submenu(top,submenu)
      menu.current_item = get_item(menu,item)
    when 1
      item = *args
      top = Merb::Menus.default
      menu = top.current_submenu
      menu.current_item = get_item(menu,item)
    else
      raise ArgumentError.new("Wrong number of arguments given (#{args.size} for 1)")
    end
  end

  def current_menu_item
    if defined?(@@current_menu)
      action = params[:action]
      @@current_menu.items.find{|item| item.name.to_s == action}
    end
  end
end

