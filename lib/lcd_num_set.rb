class LcdNumSet

  def self.valid_hash?(hash)
    return false unless (hash.is_a?(Hash) && hash.keys==[:top,:middle,:bottom])
    hash.each_value do |value|
      return false unless (value.is_a?(String) && value.match(/^[ |_]{27}\n*$/))
    end
    return true
  end
  
  def self.valid_string?(string)
    return false unless (string.is_a?(String) && string.match(/^[0-9]{9}\n*$/))
    return true
  end

  def self.split_set_hash_into_num_hashes(set_hash)
    num_hashes = []
    set_hash.each do |line_pos,line_content|
      num_parts = line_content.scan(/[ |_]{3}/)
      raise "Invalid count of number parts for line #{line_pos} in set_hash" unless num_parts.length==9
      9.times do |i|
        num_hashes[i] = {} if num_hashes[i]==nil
        num_hashes[i][line_pos] = num_parts[i]
      end
    end
    return num_hashes
  end
  
  def initialize(numset,lcdNumClass=LcdNum)
    if self.class.valid_hash?(numset) then
      initialize_from_hash(numset,lcdNumClass)
    elsif self.class.valid_string?(numset) then
      initialize_from_string(numset,lcdNumClass)
    else
      raise 'numset must be a string or hash of valid format'
    end
  end
  
  def to_s
    str = ''
    @lcdnums.each do |lcdnum|
      str << lcdnum.to_fixnum.to_s
    end
    return str
  end
  
  def to_arr
    arr = []
    @lcdnums.each do |lcdnum|
      arr << lcdnum.to_hash
    end
    return arr
  end
  
  private
  
  def initialize_from_string(string, lcdNumClass)
    @lcdnums = []
    string.strip.each_char do |char|
      @lcdnums << lcdNumClass.new(char.to_i)
    end
  end
  
  def initialize_from_hash(hash, lcdNumClass)
    num_hashes = self.class.split_set_hash_into_num_hashes(hash)
    @lcdnums = []
    num_hashes.each do |num_hash|
      @lcdnums << lcdNumClass.new(num_hash)
    end
  end
  
end