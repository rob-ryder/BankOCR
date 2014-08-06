require_relative 'bootstrap'
[

    #class spec files to run (omit "_spec.rb")
    'account_number_interpreter'


].each {|klass| require_relative 'spec/'+klass+'_spec'}