require File.dirname(__FILE__) + '/../spec_helper'

describe Merb::Menus::Item do
  before do
    @menu = Merb::Menus::Menu.new(:foo)
    @menu.display_style(:split) {|thing| thing.to_s.split("_").join(" ")}

    @submenu = Merb::Menus::Submenu.new(:cakes, @menu)
    @submenu.use_display_style(:split)

    @cheesecake = Merb::Menus::Item.new(:name => :cheese_cake, :submenu => @submenu)
    @spongecake = Merb::Menus::Item.new(:name => :sponge, :submenu => @submenu, :anchor => "sPOnge cAkE")
    @poundcake = Merb::Menus::Item.new(:name => :pound, :submenu => @submenu, :href => "http://bettercakesite")
  end

  it "has a unique key"
  it "has a submenu" do
    @cheesecake.submenu.should == @submenu
  end

  it "sets the anchor based on display rule in submenu" do
    @cheesecake.anchor.should == "cheese cake"
  end

  it "overrides default display style if given in opts" do
    @spongecake.anchor.should == "sPOnge cAkE"
  end

  it "generates a url" do
    @cheesecake.href.should == "/cakes/cheese_cake"
    @spongecake.href.should == "/cakes/sponge"
    @poundcake.href.should == "http://bettercakesite"
  end

end


