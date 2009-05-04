require File.dirname(__FILE__) + '/../spec_helper'

describe MenuGenerator::Submenu do
  before do
    MenuGenerator::Menu.new :foo
    @submenu = MenuGenerator::Submenu.new(:berries, MenuGenerator::Menu[:foo])
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

