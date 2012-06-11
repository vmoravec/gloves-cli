#!/usr/bin/env ruby
require 'rubygems'
require 'gli'

begin
  require 'terminal-table'
  require 'rainbow'
  require 'glove/timezone'
rescue LoadError
  require 'open4'
  require 'terminal-table'
  require 'rainbow'
  yast_path = File.join(File.dirname(__FILE__), '..', '..', 'lib')
  $LOAD_PATH.unshift yast_path
  $LOAD_PATH.unshift yast_path + '/libconfigagent/lib'
  $LOAD_PATH.unshift yast_path + '/config_agent-timezone/lib'
  require 'gloves-timezone/lib/glove/timezone'
end

include GLI::App

program_desc 'Command line user interface for Timezone Glove'


desc 'List available time zones'
#arg_name 'Describe arguments to timezone here'
command :list do |c|

  c.desc 'Show a list of all time zones'
  c.switch [:t, :timezones]

  c.desc 'Group time zones into regions'
  c.flag [:r, :regions], :default_value => 'all' # FIXME default_value does not work?

  c.action do |global_options,options,args|

    # If you have any errors, just raise them
    # raise "that command made no sense"
    timezone = Glove::Timezone
    args = {}
    args["kind"]        = "timezones" if options[:timezones]
    if options[:regions]
      args["kind"]        = "regions"
      args["only"]        = options[:regions] unless options[:regions] == "all"
    end
    regions = timezone.read args#'kind'=>'regions', 'only' => 'Europe'
    puts regions.inspect
  end
end

desc 'Time zone configuration summary'
command :summary do |c|
  c.action do |global_options,options,args|
    timezone = Glove::Timezone::read({})
    puts "Default Timezone: #{timezone['default_timezone']}" if timezone['default_timezone']
    puts "Current Timezone: #{timezone['timezone']}"
    puts "Hardware Clock: #{timezone['hwclock']}"
  end
end

desc 'Set new values for time zone configuration'
command :set do |c|
  c.action do |global_options,options,args|
puts "options #{options.inspect}"
puts "args #{args.inspect}"
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
