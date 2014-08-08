require 'Pathname'

require_relative 'constants'
require_relative 'lib/lcd_num_file'

raw_file_path = BASEDIR+'/scans/example1.txt'
raw_file = File.new(raw_file_path)
lcd_num_file = LcdNumFile.new(raw_file)

puts lcd_num_file.convert