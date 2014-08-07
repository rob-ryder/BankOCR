require_relative '../lib/lcd_num'

describe LcdNum do
  

  valid_test_hash   = {:top=>' _ ',:middle=>'| |',:bottom=>'|_|'}  #valid hash equivalent of valid_test_fixnum below, to be used across specs
  valid_test_fixnum = 0                                            #valid fixnum equivalent of valid_test_hash above, to be used across specs
  
  
  context "LcdNum class" do

    context "when validating fixnum" do
      
      it "should return false for parameter that is not a fixnum" do
        expect(LcdNum.valid_fixnum?('3')).to be false
      end

      it "should return false for a fixnum outside of range 0 to 9" do
        expect(LcdNum.valid_fixnum?(15)).to be false
      end
      
      it "should return true for a fixnum between 0 and 9" do
        expect(LcdNum.valid_fixnum?(valid_test_fixnum)).to be true
      end
      
    end

    context "when validating hash" do

      it "should return false for parameter that is not a hash" do
        expect(LcdNum.valid_hash?(['','',''])).to be false
      end

      it "should return false for hash that is not correctly formatted" do
        expect(LcdNum.valid_hash?({:invalid=>'item'})).to be false
      end
      
      it "should return true for hash that is correctly formatted" do
        expect(LcdNum.valid_hash?(valid_test_hash)).to be true
      end
      
    end
      
  end

  
  
  context "LcdNum objects" do

    context "when instantiated" do

      it "should return an instance of LcdNum when instantiated with no parameters" do
        expect(LcdNum.new()).to be_an_instance_of(LcdNum)
      end

      it "should return an instance of LcdNum when instantiated with one parameter (Fixnum or Hash)" do
        expect(LcdNum.new(valid_test_hash)).to be_an_instance_of(LcdNum)
        expect(LcdNum.new(valid_test_fixnum)).to be_an_instance_of(LcdNum)
      end

      it "should raise an exception when instantiated with parameter of incorrect type (not Fixnum or Hash)" do
        expect{LcdNum.new('5')}.to raise_error
        expect{LcdNum.new(Array.new)}.to raise_error
      end

      it "should raise an exception when instantiated with a parameter value that is not supported (e.g. 10)" do
        expect{LcdNum.new(22)}.to raise_error
        expect{LcdNum.new({:unsupported=>'value'})}.to raise_error
      end

    end
    
    context "when accessing values" do

      lcd_num = LcdNum.new(valid_test_fixnum)
      
      it "should output a correct fixnum when calling to_fixnum" do
        returned_val = lcd_num.to_fixnum
        expected_val = valid_test_fixnum
        expect(returned_val).to be_an_instance_of(Fixnum)
        expect(returned_val).to eql(expected_val)
      end

      it "should output a correct hash when calling to_hash" do
        returned_val = lcd_num.to_hash
        expected_val = valid_test_hash
        expect(returned_val).to be_an_instance_of(Hash)
        expect(returned_val).to eql(expected_val)
      end
      
    end

  end
  
  
  
end