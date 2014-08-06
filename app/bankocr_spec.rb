require_relative 'bootstrap'
[

    #class spec files to run (omit "_spec.rb")
    'account_numbers_file'


].each {|klass| require_relative 'spec/'+klass+'_spec'}