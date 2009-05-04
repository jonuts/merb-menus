require File.dirname(__FILE__) + '/spec_helper'

describe Merb::Menus::DisplayStyle do
  before do
    @menu = Merb::Menus::Menu.new(:foo)
    @split_rule = Merb::Menus::DisplayStyle.new(:split,@menu){|thing| thing.to_s.split("_").join(" ")}
    @splitncap = Merb::Menus::DisplayStyle.new(:split,@menu){|thing| thing.to_s.split("_").join(" ")}
    @dollarfy = Merb::Menus::DisplayStyle.new(:dollar,@menu){|thing| "$#{thing.to_s.gsub(/_/,',')}"}
  end

  it "has a unique key" do
    @split_rule.key.should == :split
    @splitncap.key.should == :split

    @split_rule.rule.call("hello_thar").should == "hello thar"
    @splitncap.rule.call("wut_the_deal").should == "wut the deal"
  end

  it "has a styling rule" do
    Merb::Menus::DisplayStyle.add_rule(:feh).should be_nil
  end
end

