require File.dirname(__FILE__) + '/spec_helper'

class Application < Merb::Controller
  create_menu :main do
    submenu :cakes, :href => "/cakes" do
      item :cheese
      item :chocolate
      item :devils_food, :anchor => "Devil's Food"
    end

    submenu :beers, :href => "/beers" do
      item :budweiser
      item :rolling_rock
      item :fosters, :anchor => "Foster's"
      item :fat_tire
    end

    submenu :drinks, :href => "/drinks" do
      item :soda
    end
     
  end
end

class Cakes < Application
  use_menu :main

  # this should be associated with item :cheese
  def cheese
    'hello'
  end

  def chocolate
    menu_item :beers, :budweiser

    'word up'
  end

  def not_devils_food
    # associate this action with item :devils_food
    menu_item :devils_food

    ':)'
  end
end

class Beers < Application
  def fat_tire
    'yoink'
  end
end

class Snack < Application
  use_menu :main, :cakes

  def cheese_cake
    menu_item :cheese
    
    [current_menu, current_submenu, current_item].join(" ")
  end

  def pistachios
    [current_menu, current_submenu, current_item].join(" ")
  end
end

class Drinks < Application
  def soda
    "#{current_menu}/#{current_submenu}/#{current_item}"
  end
end

describe "menu generator", "Merb::Controller" do
  before do
    @menu = Merb::Menus[:main]
  end

  it "should create the menu" do
    @menu.name.should == :main
  end

  it "should create all the submenus" do
    @menu.submenus.should have(3).things
    @menu.submenus.first.name.should == :cakes
  end

  it "should create the submenu items" do
    @menu.submenus.first.items.should have(3).things
    @menu.submenus.first.items.map{|e| e.name}.should == [:cheese, :chocolate, :devils_food]

    @menu.submenus[1].items.should have(4).things
    @menu.submenus[1].items.map{|e| e.name}.should == [:budweiser, :rolling_rock, :fosters, :fat_tire]
  end

  it "is accessible from child controllers"

  it "sets the current menu properly" do
    request('/cakes/cheese')
    top = Merb::Menus[:main]
    top.current_submenu.name.should == :cakes
    top.current_submenu.current_item.name.should == :cheese
  end

  it "overrides actions default menu item" do
    request('/cakes/chocolate')
    top = Merb::Menus[:main]
    top.current_submenu.name.should == :beers
    top.current_submenu.current_item.name.should == :budweiser
  end

  it "finds the correct controller/action combo automagically" do
    request '/beers/fat_tire'
    Merb::Menus.current_menu.name.should == :main
    Merb::Menus.current_menu.current_submenu.name.should == :beers
    Merb::Menus.current_menu.current_submenu.current_item.name.should == :fat_tire
  end

  it "has helpers to access current menu data" do
    req = request '/drinks/soda'

    req.body.to_s.should == "main/drinks/soda"
  end

  it do
    req = request '/snack/cheese_cake'
    req.body.to_s.should == "main cakes cheese"
  end

  it "resets all current menus before each request" do
    req = request '/snack/pistachios'
    req.body.to_s.should_not == "main cakes cheese" #this would happen w/o the reset
    req.body.to_s.should == "main cakes "
  end

   
end

