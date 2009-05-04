require File.dirname(__FILE__) + '/../spec_helper'

describe Merb::Menus::Submenu do
  before do
    Merb::Menus::Menu.new :foo
    @submenu = Merb::Menus::Submenu.new(:berries, Merb::Menus::Menu[:foo])
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

