require File.dirname(__FILE__) + '/spec_helper'

class ParentController < Merb::Controller
  include MenuGenerator::MainMenuMixin

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

class CakeController < ParentController
  use_menu :main, :cakes

  # this should be associated with item :cheese
  def cheese
  end

  def chocolate
  end

  def not_devils_food
    # associate this action with item :devils_food
    menu_item :devils_food
  end
end

class BeerController < ParentController
end

class SnackController < ParentController
  use_menu :main, :cakes

  def cheese_cake
    menu_item :main, :cakes, :cheese
  end
end

describe "menu generator" do
  before do
    @menu = MenuGenerator::Menu[:main]
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

  it "is accessible from child controllers" do
    ChildController.

end

