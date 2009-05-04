$:.push File.join(File.dirname(__FILE__), '..', 'lib')

require 'rubygems'
require 'spec'
require 'merb-core'
require 'merb-core/test'
require 'merb-menus'

Merb::Router.prepare {default_routes}

Merb.start :environment => "test", :adapter => "runner"

Spec::Runner.configure {|config| 
  config.include(Merb::Test::RouteHelper)
}

