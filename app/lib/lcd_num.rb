class LcdNum

  #---class_methods---
  
  def self.valid_hash?(hash)
    return false unless (hash.is_a?(Hash) && hash.keys==[:top,:middle,:bottom])
    hash.each_value do |value|
      return false unless (value.is_a?(String) && value.match(/^[ |_]{3}$/))
    end
    return true
  end

  def self.valid_fixnum?(num)
    return false unless (num.is_a?(Fixnum) && num>=0 && num<=9)
    return true
  end

  def self.signature_map
    {
        :' _ | ||_|' => 0,
        :'     |  |' => 1,
        :' _  _||_ ' => 2,
        :' _  _| _|' => 3,
        :'   |_|  |' => 4,
        :' _ |_  _|' => 5,
        :' _ |_ |_|' => 6,
        :' _   |  |' => 7,
        :' _ |_||_|' => 8,
        :' _ |_| _|' => 9
    }
  end

  #---object_methods---
  
  def initialize(value=0)
    @signature = nil
    if(self.class.valid_fixnum?(value))
      initialize_from_fixnum(value)
    elsif(self.class.valid_hash?(value))
      initialize_from_hash(value)
    else
      raise "Invalid parameter given to #{self.class}.new"
    end
  end
  
  def to_fixnum
    return self.class.signature_map[@signature]
  end
  
  def to_hash
    sig_string = @signature.to_s
    return {
        :top    => sig_string[0,3],
        :middle => sig_string[3,3],
        :bottom => sig_string[6,3]
    }
  end
  
  private

  #---private_object_methods---
  
  def initialize_from_fixnum(init_num)
    self.class.signature_map.each do |sig,map_num|
      @signature=sig if init_num==map_num
    end
    raise "Invalid fixnum, no signature matched" if @signature==nil
  end
  
  def initialize_from_hash(hash)
    expected_sig = (hash[:top]+hash[:middle]+hash[:bottom]).to_sym
    if self.class.signature_map.has_key?(expected_sig)
      @signature = expected_sig
    else
      raise "Invalid hash, no signature matched"
    end
  end
  
end