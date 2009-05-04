require File.dirname(__FILE__) + '/spec_helper'

describe MenuGenerator::DisplayStyle do
  before do
    @menu = MenuGenerator::Menu.new(:foo)
    @split_rule = MenuGenerator::DisplayStyle.new(:split,@menu){|thing| thing.to_s.split("_").join(" ")}
    @splitncap = MenuGenerator::DisplayStyle.new(:split,@menu){|thing| thing.to_s.split("_").join(" ")}
    @dollarfy = MenuGenerator::DisplayStyle.new(:dollar,@menu){|thing| "$#{thing.to_s.gsub(/_/,',')}"}
  end

  it "has a unique key" do
    @split_rule.key.should == :split
    @splitncap.key.should == :split

    @split_rule.rule.call("hello_thar").should == "hello thar"
    @splitncap.rule.call("wut_the_deal").should == "wut the deal"
  end

  it "has a styling rule" do
    MenuGenerator::DisplayStyle.add_rule(:feh).should be_nil
  end
end

