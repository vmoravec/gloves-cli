#!/usr/bin/env ruby
require 'rubygems'
require 'gli'

begin
  require 'glove/language'
rescue LoadError
  require 'open4'
  yast_path = File.join(File.dirname(__FILE__), '..', '..', 'lib')
  $LOAD_PATH.unshift yast_path
  $LOAD_PATH.unshift yast_path + '/libconfigagent/lib'
  $LOAD_PATH.unshift yast_path + '/config_agent-language/lib'
  require 'gloves-language/lib/glove/language'
end

include GLI::App

program_desc 'Command line user interface for Language Glove'


desc 'List available languages'
command :list do |c|

  c.action do |global_options,options,args|

    languages           = Glove::Language::read "kind" => "languages"
    puts languages["languages"].inspect
  end
end

desc 'Language configuration summary'
command :summary do |c|
  c.action do |global_options,options,args|
    language = Glove::Language::read({})
    puts "Current Language: #{language['language']}"
    puts "Installed Languages: #{language['languages']}" if language['languages']
  end
end

pre do |global,command,options,args|
  # Pre logic here
  # Return true to proceed; false to abourt and not call the
  # chosen command
  # Use skips_pre before a command to skip this block
  # on that command only
  true
end

on_error do |exception|
  # Error logic here
  # return false to skip default error handling
  true
end

exit run(ARGV)
