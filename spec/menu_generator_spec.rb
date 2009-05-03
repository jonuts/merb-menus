require File.dirname(__FILE__) + '/spec_helper'

describe MenuGenerator::Item do
  before do
    MenuGenerator::MainMenu.display_rule(:split){|thing| thing.to_s.split("_").join(" ")}
    @submenu = MenuGenerator::Submenu.new(:cakes)
    @submenu.use_display_rule(:split)

    @cheesecake = MenuGenerator::Item.new(:name => :cheese_cake, :submenu => @submenu)
    @spongecake = MenuGenerator::Item.new(:name => :sponge, :submenu => @submenu, :anchor => "sPOnge cAkE")
    @poundcake = MenuGenerator::Item.new(:name => :pound, :submenu => @submenu, :href => "http://bettercakesite")
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

describe MenuGenerator::Submenu do
  before do
    @submenu = MenuGenerator::Submenu.new(:berries)
    @submenu.item(:straw)
    @submenu.item(:rasp)
    @submenu.item(:black, :anchor => "HELLOTHAR", :url => "eek")
  end

  it "has a unique key" do
    @submenu.name.should == :berries
  end

  it "has a collection of items" do
    @submenu.items.should have(3).things
  end

  it 'sets item properly' do
    item = @submenu.items.first
    item.name.should == :straw
    item.submenu.should == @submenu
    item.anchor.should == "straw"
    item.href.should == "/berries/straw"
  end
end

describe MenuGenerator::MainMenu do
  before do
    MenuGenerator::MainMenu.submenu(:foo){}
    MenuGenerator::MainMenu.submenu(:bar){}
  end

  it "tracks submenus" do
    MenuGenerator::MainMenu.submenus.should have(2).things
  end

  it "stores different display rules"
  it "defines a url generator"
  it "has a default url generation method"
end

