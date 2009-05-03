$:.push File.join(File.dirname(__FILE__), '..', 'lib')

require 'rubygems'
require 'merb-core'
require 'merb-core/test'
require 'menu_generator'

Merb.start :environment => "test", :adapter => "runner"

