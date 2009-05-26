require File.dirname(__FILE__) + '/../spec_helper'

describe Merb::Menus::Menu do
  before do
    @menu = Merb::Menus::Menu.new(:foo)
    @menu.submenu(:wutup){}
    @menu.submenu(:dog){}
  end

  it "tracks submenus" do
    @menu.submenus.should have(2).things
  end

  it "stores different display rules"
  it "defines a url generator"
  it "has a default url generation method"
end

describe Merb::Menus::Menu, "#submenu" do
  before do
    @menu = Merb::Menus::Menu.new(:hellothar)
  end

  it "creates a submenu without taking a block" do
    lambda{@menu.submenu(:foo)}.should_not raise_error(ArgumentError)
    @menu.submenus.should have(1).item
    @menu.submenus.first.name.should == :foo
  end
end

