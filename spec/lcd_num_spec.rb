describe LcdNum do

  
  valid_test_fixnum = 0
  valid_test_hash   = {
      :top    => ' _ ',
      :middle => '| |',
      :bottom => '|_|'
  }
  valid_broken_hash   = {
      :top    => '   ',
      :middle => '| |',
      :bottom => '|_|'
  }
  expected_corrections = [0]
  
  
  describe '.valid_fixnum?' do
    
    it 'returns false for string' do
      expect(described_class.valid_fixnum?('')).to be false
    end

    it 'returns false for fixnum 15' do
      expect(described_class.valid_fixnum?(15)).to be false
    end
    
    it "returns true for fixnum of #{valid_test_fixnum}" do
      expect(described_class.valid_fixnum?(valid_test_fixnum)).to be true
    end
    
  end

  
  describe '.valid_hash?' do

    it 'returns false for array' do
      expect(described_class.valid_hash?([])).to be false
    end

    it 'returns false for hash of {:invalid=>"item"}' do
      expect(described_class.valid_hash?({:invalid=>'item'})).to be false
    end
    
    it "returns true for hash of #{valid_test_hash}" do
      expect(described_class.valid_hash?(valid_test_hash)).to be true
    end

    it 'returns true for hash of @valid_broken_hash' do
      expect(described_class.valid_hash?(valid_broken_hash)).to be true
    end
    
  end


  describe '#initialize' do

    it "returns #{described_class} object when NOT given a variable" do
      expect(described_class.new).to be_an_instance_of(described_class)
    end

    it "returns #{described_class} object when given a hash of #{valid_test_hash}" do
      expect(described_class.new(valid_test_hash)).to be_an_instance_of(described_class)
    end

    it "returns #{described_class} object when given a hash of @valid_broken_hash" do
      expect(described_class.new(valid_broken_hash)).to be_an_instance_of(described_class)
    end

    it "returns #{described_class} object when given a fixnum of #{valid_test_fixnum}" do
      expect(described_class.new(valid_test_fixnum)).to be_an_instance_of(described_class)
    end

    it 'raises an exception when given a string' do
      expect{described_class.new('')}.to raise_error
    end

    it 'raises an exception when given a fixnum of 15' do
      expect{described_class.new(15)}.to raise_error
    end

    it 'raises an exception when given a hash of {:unsupported=>"value"}' do
      expect{described_class.new({:unsupported=>'value'})}.to raise_error
    end

  end
  
  
  describe '#to_fixnum' do
    
    it 'returns a fixnum' do
      expect(described_class.new(valid_test_fixnum).to_fixnum).to be_an_instance_of(Fixnum)
    end
    
    it "returns #{valid_test_fixnum} when sent to an object initialized with #{valid_test_fixnum}" do
      instance = described_class.new(valid_test_fixnum)
      expect(instance.to_fixnum).to eql(valid_test_fixnum)
    end

    it 'returns -1 when sent to an object initialized with @valid_broken_hash' do
      instance = described_class.new(valid_broken_hash)
      expect(instance.to_fixnum).to eql(-1)
    end
    
  end
  
  
  describe '#to_hash' do

    it 'returns a hash' do
      expect(described_class.new(valid_test_fixnum).to_hash).to be_an_instance_of(Hash)
    end

    it "returns #{valid_test_hash} when sent to an object initialized with #{valid_test_hash}" do
      instance = described_class.new(valid_test_hash)
      expect(instance.to_hash).to eql(valid_test_hash)
    end

    it 'returns @valid_broken_hash when sent to an object initialized with @valid_broken_hash' do
      instance = described_class.new(valid_broken_hash)
      expect(instance.to_hash).to eql(valid_broken_hash)
    end

  end
  
  
  describe '#corrections' do
    
    return_val = described_class.new(valid_broken_hash).corrections
    
    it 'returns an array' do
      expect(return_val).to be_an_instance_of(Array)
    end
    
    it 'returns @expected_corrections for @valid_broken_hash' do
      expect(return_val).to eql(expected_corrections)
    end
    
  end


end