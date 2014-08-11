require_relative 'lcd_num'

class LcdNumRow

  #---class_methods---
  
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
  
  def self.valid_account_num?(num_string)
    return false unless self.valid_string?(num_string)
    checksum = 0
    multiplier = 1
    num_string.reverse.each_char do |num|
      checksum += (num.to_i * multiplier)
      multiplier += 1
    end
    return (checksum.modulo(11)==0)
  end

  def self.split_row_hash_into_num_hashes(row_hash)
    num_hashes = []
    row_hash.each do |line_pos,line_content|
      num_parts = line_content.scan(/[ |_]{3}/)
      raise "Invalid count of number parts for line #{line_pos} in row_hash" unless num_parts.length==9
      9.times do |i|
        num_hashes[i] = {} if num_hashes[i]==nil
        num_hashes[i][line_pos] = num_parts[i]
      end
    end
    return num_hashes
  end

  #---object_methods---
  
  def initialize(num_row,lcdNumClass=LcdNum)
    if self.class.valid_hash?(num_row) then
      initialize_from_hash(num_row,lcdNumClass)
    elsif self.class.valid_string?(num_row) then
      initialize_from_string(num_row,lcdNumClass)
    else
      raise 'num_row must be a string or hash of valid format'
    end
  end
  
  def to_s
    str = ''
    @lcdnums.each do |lcdnum|
      fixnum = lcdnum.to_fixnum
      if fixnum < 0 then
        str << '?'
      else
        str << fixnum.to_s
      end
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
  
  def to_hash
    hash = {
      :top    => '',
      :middle => '',
      :bottom => ''
    }
    @lcdnums.each do |lcdnum|
      hash[:top]    << lcdnum.to_hash[:top]
      hash[:middle] << lcdnum.to_hash[:middle]
      hash[:bottom] << lcdnum.to_hash[:bottom]
    end
    return hash
  end
  
  def is_valid_account_num?
    return self.class.valid_account_num?(self.to_s)
  end
  
  def corrections

    #send back empty array if this row is a valid account number already
    return [] if is_valid_account_num?
    
    #calculate valid rows by replacing broken digits only
    valid_rows = corrections_rows(corrections_digit_candidates(:broken_digits_only))

    #if fixing these broken digits hasn't produced a valid set,
    # attempt to modify every digit to find a valid set
    if valid_rows.empty? then
      valid_rows = corrections_rows(corrections_digit_candidates(:all_digits))
    end
    
    #return valid rows
    return valid_rows
    
  end
  
  private

  #---private_object_methods---
  
  def initialize_from_string(string, lcdNumClass)
    @lcdnums = []
    string.strip.each_char do |char|
      @lcdnums << lcdNumClass.new(char.to_i)
    end
  end
  
  def initialize_from_hash(hash, lcdNumClass)
    num_hashes = self.class.split_row_hash_into_num_hashes(hash)
    @lcdnums = []
    num_hashes.each do |num_hash|
      @lcdnums << lcdNumClass.new(num_hash)
    end
  end
  
  def corrections_digit_candidates(mode = :all_digits)
    row_num_candidates = {0=>[], 1=>[], 2=>[], 3=>[], 4=>[], 5=>[], 6=>[], 7=>[], 8=>[]}
    @lcdnums.each_with_index do |lcdnum,index|
      candidates = []
      fixnum = lcdnum.to_fixnum
      if( mode==:all_digits || fixnum<0 ) then
        candidates += lcdnum.corrections
      end
      row_num_candidates[index] = candidates.compact
    end
    return row_num_candidates
  end
  
  def corrections_rows(digit_candidates)
    possible_rows = []
    9.times do |i|
      digit_candidates[i].each do |replacement|
        test_str = self.to_s
        test_str[i] = replacement.to_s
        if self.class.valid_account_num?(test_str) then
          possible_rows << test_str
        end
      end
    end
    return possible_rows
  end
  
end