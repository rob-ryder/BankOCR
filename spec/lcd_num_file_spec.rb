describe LcdNumFile do

  
  invalid_lcd_file = File.new(BASEDIR+'/scans/example2.txt')
  valid_lcd_file = File.new(BASEDIR+'/scans/example1.txt')
  valid_lcd_string = "123456789 ERR\n678902345 ERR\n603?58912 ILL\n910000000\n"
  
  
  describe '.valid_file?' do

    it 'returns false when given a string' do
      expect(described_class.valid_file?('../scans/example1.txt')).to be false
    end
    
    it 'returns false when given @invalid_lcd_file' do
      expect(described_class.valid_file?(invalid_lcd_file)).to be false
    end
    
    it 'returns true when given @valid_lcd_file' do
      expect(described_class.valid_file?(valid_lcd_file)).to be true
    end
    
  end
  
  
  describe '#initialize' do

    it 'raises an exception when given a string' do
      expect{described_class.new('')}.to raise_error
    end

    it 'raises an exception when given @invalid_lcd_file' do
      expect{described_class.new(invalid_lcd_file)}.to raise_error
    end

    it "returns a #{described_class} object when given @valid_lcd_file" do
      expect(described_class.new(valid_lcd_file)).to be_an_instance_of(described_class)
    end

  end

  
  context 'when initialized with @valid_lcd_file' do
  
    describe '.convert' do
      
      let(:obj) { described_class.new(valid_lcd_file) }
      
      it 'returns a string of value @valid_lcd_string' do
        return_val = obj.convert
        expect(return_val).to be_an_instance_of(String)
        expect(return_val).to eql(valid_lcd_string)
      end
      
    end
    
  end
  
  
end