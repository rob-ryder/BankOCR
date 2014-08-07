#include resources
require_relative 'lib/account_number_interpreter'

#set base directory for project
require 'Pathname'
BASEDIR = Pathname.new(__FILE__).dirname.to_s

#interpret the file
interpreter = AccountNumberInterpreter.new
file = File.new(BASEDIR+'/scans/example1.txt')
interpreted_file = interpreter.interpret_file(file)

#output the result
puts interpreted_file