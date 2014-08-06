require_relative '../lib/account_number_interpreter'

describe AccountNumberInterpreter do

  it "should allow instantiation" do
    expect(AccountNumberInterpreter.new).to be_an_instance_of AccountNumberInterpreter
  end

end