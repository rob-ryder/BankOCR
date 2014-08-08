describe LcdNumSet do

  
  valid_test_set_string = '123456789'
  valid_test_set_hash = {
      :top    => '    _  _     _  _  _  _  _ ',
      :middle => '  | _| _||_||_ |_   ||_||_|',
      :bottom => '  ||_  _|  | _||_|  ||_| _|'
  }
  valid_test_num_hash_array = [
      {
          :top    => '   ',
          :middle => '  |',
          :bottom => '  |'
      },
      {
          :top    => ' _ ',
          :middle => ' _|',
          :bottom => '|_ '
      },
      {
          :top    => ' _ ',
          :middle => ' _|',
          :bottom => ' _|'
      },
      {
          :top    => '   ',
          :middle => '|_|',
          :bottom => '  |'
      },
      {
          :top    => ' _ ',
          :middle => '|_ ',
          :bottom => ' _|'
      },
      {
          :top    => ' _ ',
          :middle => '|_ ',
          :bottom => '|_|'
      },
      {
          :top    => ' _ ',
          :middle => '  |',
          :bottom => '  |'
      },
      {
          :top    => ' _ ',
          :middle => '|_|',
          :bottom => '|_|'
      },
      {
          :top    => ' _ ',
          :middle => '|_|',
          :bottom => ' _|'
      }
  ]


  describe '.valid_hash?' do

    it 'returns false when given an array' do
      expect(described_class.valid_hash?([])).to be false
    end

    it 'returns false when given a hash of {:invalid=>"format"}' do
      expect(described_class.valid_hash?({:invalid=>'format'})).to be false
    end

    it 'returns true when given a hash of @valid_test_set_hash' do
      expect(described_class.valid_hash?(valid_test_set_hash)).to be true
    end

  end


  describe '.valid_string?' do

    it 'returns false when given an integer' do
      expect(described_class.valid_string?(123456789)).to be false
    end

    it 'returns false when given a string of "invalid format"' do
      expect(described_class.valid_string?('invalid format')).to be false
    end

    it 'returns true when given a string of @valid_test_set_string' do
      expect(described_class.valid_string?(valid_test_set_string)).to be true
    end

  end


  describe '.split_set_hash_into_num_hashes' do
    
    it 'returns array of @valid_test_num_hash_array when given hash of @valid_test_set_hash' do
      return_val = described_class.split_set_hash_into_num_hashes(valid_test_set_hash)
      expect(return_val).to be_an_instance_of(Array)
      expect(return_val).to eql(valid_test_num_hash_array)
    end
    
  end
  
  
  describe '#initialize' do

    it 'raises an exception when given an array' do
      expect{described_class.new([])}.to raise_error
    end
    
    it 'raises an exception when given a hash of {:invalid=>"format"}' do
      expect{described_class.new({:invalid=>'format'})}.to raise_error
    end

    it 'raises an exception when given a string of "invalid format"' do
      expect{described_class.new('invalid format')}.to raise_error
    end

    it "returns a #{described_class} object when given a hash of @valid_test_set_hash" do
      expect(described_class.new(valid_test_set_hash)).to be_an_instance_of(described_class)
    end

    it "returns a #{described_class} object when given a string of @valid_test_set_string" do
      expect(described_class.new(valid_test_set_string)).to be_an_instance_of(described_class)
    end

  end

  
  shared_examples "a lcd_num_set converter" do
    describe '#to_s' do
      it 'returns a string of value @valid_test_set_string' do
        return_val = obj.to_s
        expect(return_val).to be_an_instance_of(String)
        expect(return_val).to eql(valid_test_set_string)
      end
    end
    describe '#to_arr' do
      it 'returns an array of value @valid_test_num_hash_array' do
        return_val = obj.to_arr
        expect(return_val).to be_an_instance_of(Array)
        expect(return_val).to eql(valid_test_num_hash_array)
      end
    end
  end

  context 'an object initialized with a hash of @valid_test_set_hash' do
    it_behaves_like 'a lcd_num_set converter' do
       let(:obj){described_class.new(valid_test_set_hash)} 
    end
  end

  context 'an object initialized with a hash of @valid_test_set_string' do
    it_behaves_like 'a lcd_num_set converter' do
      let(:obj){described_class.new(valid_test_set_string)}
    end
  end

end