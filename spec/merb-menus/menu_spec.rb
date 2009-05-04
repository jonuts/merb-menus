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


