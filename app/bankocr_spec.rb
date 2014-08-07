require_relative 'bootstrap'
[

    #class spec files to run (omit "_spec.rb")
    'account_number_interpreter',
    'lcd_num'


].each {|klass| require_relative 'spec/'+klass+'_spec'}