describe LcdNumSet do

  
  valid_test_string = '123456789'
  valid_test_object = described_class.new
  valid_test_hash = {
      :top    => '    _  _     _  _  _  _  _ ',
      :middle => '  | _| _||_||_ |_   ||_||_|',
      :bottom => '  ||_  _|  | _||_|  ||_| _|'
  }
  
  
  describe '#initialize' do

    it "returns #{described_class} object when NOT given a variable" do
      expect(described_class.new).to be_an_instance_of(described_class)
    end

  end

  
end