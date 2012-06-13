#!/usr/bin/env ruby
require 'rubygems'
require 'gli'

begin
  require 'glove/timezone'
rescue LoadError
  require 'open4'
  yast_path = File.join(File.dirname(__FILE__), '..', '..', 'lib')
  $LOAD_PATH.unshift yast_path
  $LOAD_PATH.unshift yast_path + '/libconfigagent/lib'
  $LOAD_PATH.unshift yast_path + '/config_agent-timezone/lib'
  require 'gloves-timezone/lib/glove/timezone'
end

include GLI::App

program_desc 'Command line user interface for Timezone Glove'


desc 'List available time zones'
command :list do |c|

  c.desc 'Show a list of all time zones'
  c.switch [:t, :timezones]

  c.desc 'Show time zones from specific region'
  c.default_value 'all'
  c.flag [:r, :regions]

  c.action do |global_options,options,args|

    # If you have any errors, just raise them
    # raise "that command made no sense"
    timezone = Glove::Timezone
    params              = {}
    params["kind"]      = "timezones" if options[:timezones]
    if options[:regions]
      params["kind"]        = "regions"
      params["only"]        = options[:regions] unless options[:regions] == "all"
    end
    regions = timezone.read params
    puts regions.inspect
  end
end

desc 'Show the default time zone for given language'
command :language do |c|

  c.action do |global_options,options,args|
    language = Glove::Timezone.read "kind" => "language", "language" => args[0]
    puts language["timezone"]
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

desc 'Set new time zone'
command :set do |c|

  c.desc 'Hardware Clock ("localtime" or "UTC")'
  c.flag [:h, :hwclock]


  c.action do |global_options,options,args|

#FIXME usage of args is not visible in help
    params      = {}
    params["timezone"]  = args[0] if args[0]
    if options[:hwclock]
      hwclock = "--localtime" if options[:hwclock] == "localtime"
      hwclock = "-u" if options[:hwclock].downcase == "utc"
      params["hwclock"]   = hwclock unless hwclock.nil?
    end
    params["apply"]     = true unless params.empty?
    Glove::Timezone::modify({}, params)
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
