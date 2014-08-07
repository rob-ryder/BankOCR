describe LcdNumSet do

  
  valid_test_string = '123456789'
  valid_test_hash = {
      :top    => '    _  _     _  _  _  _  _ ',
      :middle => '  | _| _||_||_ |_   ||_||_|',
      :bottom => '  ||_  _|  | _||_|  ||_| _|'
  }
  
  
  describe '.valid_hash?' do
    
    it 'returns false when given an array' do 
      expect(described_class.valid_hash?([])).to be false
    end

    it 'returns false when given a hash of {:invalid=>"format"}' do
      expect(described_class.valid_hash?({:invalid=>'format'})).to be false
    end
    
    it 'returns true when given a hash of @valid_test_hash' do
      expect(described_class.valid_hash?(valid_test_hash)).to be true
    end
    
  end
  
  
  describe '#initialize' do

    it 'raises an exception when given an array' do
      expect{described_class.new([])}.to raise_error
    end
    
    it 'raises an exception when given a hash of {:invalid=>"format"}' do
      expect{described_class.new({:invalid=>'format'})}.to raise_error
    end

    it "returns a #{described_class} object when given a hash of @valid_test_hash" do
      expect(described_class.new(valid_test_hash)).to be_an_instance_of(described_class)
    end

  end

  
end