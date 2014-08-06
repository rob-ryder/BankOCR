#include resources
require_relative 'bootstrap'
require_relative 'lib/account_number_interpreter'

#set location of file to interpret
scan_file_path = BASEDIR+'/scans/example1.txt'

#interpret the file
puts AccountNumberInterpreter.new.interpret_file(File.new(scan_file_path))