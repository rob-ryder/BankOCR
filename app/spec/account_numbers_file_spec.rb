require_relative '../lib/account_numbers_file'

describe AccountNumbersFile do

  it "should extend File" do
    expect(AccountNumbersFile.ancestors[1]).to be File
  end
  
  it "should return an instance of AccountNumbersFile when initialized" do
    file = AccountNumbersFile.new(BASEDIR+'/scans/example1.txt')
    expect(file).to be_an_instance_of AccountNumbersFile
  end
  
end