begin
  require 'gloves-cli/version.rb'
  require 'terminal-table'
  require 'rainbow'
  require 'glove/timezone'
rescue LoadError
  require 'open4'
  require 'gloves-cli/version.rb'
  require 'terminal-table'
  require 'rainbow'
  yast_path = File.join(File.dirname(__FILE__), '..', '..', 'lib')
  $LOAD_PATH.unshift yast_path
  $LOAD_PATH.unshift yast_path + '/libconfigagent/lib'
  $LOAD_PATH.unshift yast_path + '/config_agent-country/lib'
  require 'gloves-country/lib/glove/timezone'
end

#puts "GT is a constant for Glove::Timezone. Usage: GT.read 'kind' => 'timezones'"
# GT = Glove::Timezone
# @regions = GT.read 'kind'=>'regions', 'only' => 'Europe'
# @language = GT.read 'kind' => 'language'
# @table = Terminal::Table.new :title => 'Regions'.color('#3465A4'), :rows => @regions.to_a.take(10)
# puts @table
# @table = Terminal::Table.new :title => 'Language'.color(:red), :rows => @language.to_a
# puts @table

