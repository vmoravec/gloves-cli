require 'gloves/version.rb'
yast_path = File.join(File.dirname(__FILE__), '..', '..', '..', 'lib')
$LOAD_PATH.unshift yast_path
$LOAD_PATH.unshift yast_path + '/libconfigagent/lib'
$LOAD_PATH.unshift yast_path + '/config_agent-country/lib'

require 'open4'
require 'gloves-country/lib/glove/timezone'
require 'terminal-table'
require 'rainbow'

puts "GT is a constant for Glove::Timezone. Usage: GT.read 'kind' => 'timezones'"
GT = Glove::Timezone
@regions = GT.read 'kind'=>'regions', 'only' => 'Europe'
@language = GT.read 'kind' => 'language'
@table = Terminal::Table.new :title => 'Regions'.color('#3465A4'), :rows => @regions.to_a.take(10)
puts @table
@table = Terminal::Table.new :title => 'Language'.color(:red), :rows => @language.to_a
puts @table

