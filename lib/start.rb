$LOAD_PATH.unshift File.dirname __FILE__
$LOAD_PATH.unshift File.join File.dirname(__FILE__), 'libconfigagent/lib'
$LOAD_PATH.unshift File.join File.dirname(__FILE__), 'config_agent-country/lib'

require 'open4'
require 'terminal-table'
require 'rainbow'
require 'gloves-country/lib/glove/timezone'

puts "GT is a constant for Glove::Timezone. Usage: GT.read 'kind' => 'timezones'"
GT = Glove::Timezone
@regions = GT.read 'kind'=>'regions', 'only' => 'Europe'
@language = GT.read 'kind' => 'language'
@table = Terminal::Table.new :title => 'Regions'.color('#3465A4'), :rows => @regions.to_a.take(10)
puts @table
@table = Terminal::Table.new :title => 'Language'.color(:red), :rows => @language.to_a
puts @table

