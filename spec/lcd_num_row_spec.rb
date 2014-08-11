describe LcdNumRow do

  
  valid_row_string = '123456789'
  valid_row_hash = {
      :top    => '    _  _     _  _  _  _  _ ',
      :middle => '  | _| _||_||_ |_   ||_||_|',
      :bottom => '  ||_  _|  | _||_|  ||_| _|'
  }
  valid_array_of_num_hashes = [
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

  valid_broken_row_string = '123?56789'
  valid_broken_row_hash = {
      :top    => '    _  _     _  _  _  _  _ ',
      :middle => '  | _| _||_||_ |_   ||_||_|',
      :bottom => '  ||_  _|| | _||_|  ||_| _|'
  }


  describe '.valid_hash?' do

    it 'returns false when given an array' do
      expect(described_class.valid_hash?([])).to be false
    end

    it 'returns false when given a hash of {:invalid=>"format"}' do
      expect(described_class.valid_hash?({:invalid=>'format'})).to be false
    end

    it 'returns true when given a hash of @valid_row_hash' do
      expect(described_class.valid_hash?(valid_row_hash)).to be true
    end

    it 'returns true when given a hash of @valid_broken_row_hash' do
      expect(described_class.valid_hash?(valid_broken_row_hash)).to be true
    end

  end


  describe '.valid_string?' do

    it 'returns false when given an integer' do
      expect(described_class.valid_string?(123456789)).to be false
    end

    it 'returns false when given a string of "invalid format"' do
      expect(described_class.valid_string?('invalid format')).to be false
    end

    it 'returns true when given a string of @valid_row_string' do
      expect(described_class.valid_string?(valid_row_string)).to be true
    end

  end


  describe '.split_row_hash_into_num_hashes' do
    
    it 'returns array of @valid_array_of_num_hashes when given hash of @valid_row_hash' do
      return_val = described_class.split_row_hash_into_num_hashes(valid_row_hash)
      expect(return_val).to be_an_instance_of(Array)
      expect(return_val).to eql(valid_array_of_num_hashes)
    end

    it 'returns array when given a hash of @valid_broken_row_hash' do
      return_val = described_class.split_row_hash_into_num_hashes(valid_broken_row_hash)
      expect(return_val).to be_an_instance_of(Array)
    end
    
  end
  
  describe '.valid_account_num?' do
    
    it 'accepts a string' do
      expect{described_class.valid_account_num?('')}.not_to raise_error
    end
    
    it 'returns false for non-numeric string "123?_!789"' do
      expect(described_class.valid_account_num?('123?_!789')).to be false
    end

    it 'returns false for invalid account number "000000029"' do
      expect(described_class.valid_account_num?('000000029')).to be false
    end
    
    it 'returns true for valid account number "000000019"' do
      expect(described_class.valid_account_num?('000000019')).to be true
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

    it "returns a #{described_class} object when given a hash of @valid_row_hash" do
      expect(described_class.new(valid_row_hash)).to be_an_instance_of(described_class)
    end

    it "returns a #{described_class} object when given a string of @valid_row_string" do
      expect(described_class.new(valid_row_string)).to be_an_instance_of(described_class)
    end

    it "returns a #{described_class} object when given a hash of @valid_broken_row_hash" do
      expect(described_class.new(valid_broken_row_hash)).to be_an_instance_of(described_class)
    end

  end
  
  
  describe '#is_valid_account_num?' do

    it 'returns false for object initialized with "0000029" (invalid checksum)' do
      obj = described_class.new('000000029')
      expect(obj.is_valid_account_num?).to be false
    end

    it 'returns true for object initialized with "000000019" (valid checksum)' do
      obj = described_class.new('000000019')
      expect(obj.is_valid_account_num?).to be true
    end

    it 'returns false for object initialized with "000000039" (invalid checksum)' do
      obj = described_class.new('000000039')
      expect(obj.is_valid_account_num?).to be false
    end

    it 'returns false for object initialized with @valid_broken_row_hash (contains illegible character(s))' do
      obj = described_class.new(valid_broken_row_hash)
      expect(obj.is_valid_account_num?).to be false
    end

  end
  
  
  describe "#corrections" do

    it 'returns an array' do
      expect(described_class.new('123456789').corrections).to be_an_instance_of(Array)
    end
    
    it 'returns an empty array if the row is already a valid account number' do
      expect(described_class.new('000000019').corrections).to eql([])
    end
    
    it 'returns appropriate single correction for the lightly broken initialization variable given' do
      obj = described_class.new({
          :top    => ' _  _  _  _  _  _  _     _ ',
          :middle => '| || || || || || || |   |_|',
          :bottom => '|_||_||_||_||_||_||_|  | _|'
      })
      expect(obj.corrections).to eql(['000000019'])
    end
    
    it 'returns an empty array for the heavily broken initialization variable given' do
      obj = described_class.new({
          :top    => ' _     _  _  _     _  _  _ ',
          :middle => '  |   | |   |_||  |    || |',
          :bottom => ' _|  ||_||_||_||_||_||_|| |'
      })
      expect(obj.corrections).to eql([])
    end
    
    it 'returns an array with a number of entries for the non-broken initialization variable given' do
      obj = described_class.new({
          :top    => ' _  _  _  _  _  _  _  _  _ ',
          :middle => '|_ |_ |_ |_ |_ |_ |_ |_ |_ ',
          :bottom => ' _| _| _| _| _| _| _| _| _|'
      })
      expect(obj.corrections.length).to be > 1
    end
    
  end
  
  
  shared_examples 'a lcd_num_row converter' do
    describe '#to_s' do
      it 'returns a string of value @valid_row_string' do
        return_val = obj.to_s
        expect(return_val).to be_an_instance_of(String)
        expect(return_val).to eql(valid_row_string)
      end
    end
    describe '#to_arr' do
      it 'returns an array of value @valid_array_of_num_hashes' do
        return_val = obj.to_arr
        expect(return_val).to be_an_instance_of(Array)
        expect(return_val).to eql(valid_array_of_num_hashes)
      end
    end
    describe '#to_hash' do
      it 'returns a hash of value @valid_row_hash' do
        return_val = obj.to_hash
        expect(return_val).to be_an_instance_of(Hash)
        expect(return_val).to eql(valid_row_hash)
      end
    end
  end

  context 'an object initialized with a hash of @valid_row_hash' do
    it_behaves_like 'a lcd_num_row converter' do
       let(:obj){described_class.new(valid_row_hash)} 
    end
  end

  context 'an object initialized with a string of @valid_row_string' do
    it_behaves_like 'a lcd_num_row converter' do
      let(:obj){described_class.new(valid_row_string)}
    end
  end

  context 'an object initialized with a hash of @valid_broken_row_hash' do
    let(:obj){described_class.new(valid_broken_row_hash)}
    describe '#to_s' do
      it 'returns a string of value @valid_broken_row_string' do
        return_val = obj.to_s
        expect(return_val).to be_an_instance_of(String)
        expect(return_val).to eql(valid_broken_row_string)
      end
    end
    describe '#to_hash' do
      it 'returns a hash of value @valid_broken_row_hash' do
        return_val = obj.to_hash
        expect(return_val).to be_an_instance_of(Hash)
        expect(return_val).to eql(valid_broken_row_hash)
      end
    end
  end

end