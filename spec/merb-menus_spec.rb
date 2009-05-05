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
  end
end

class Cakes < Application
  use_menu :main

  # this should be associated with item :cheese
  def cheese

    puts "The current menu is: #{Merb::Menus.current_menu.name}"
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
    'foo'
  end
end

describe "menu generator" do
  before do
    @menu = Merb::Menus[:main]
  end

  it "should create the menu" do
    @menu.name.should == :main
  end

  it "should create all the submenus" do
    @menu.submenus.should have(2).things
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
end

