class LcdNumSet

  def self.valid_hash?(hash)
    return false unless (hash.is_a?(Hash) && hash.keys==[:top,:middle,:bottom])
    hash.each_value do |value|
      return false unless (value.is_a?(String) && value.match(/^[ |_]{27}\n*$/))
    end
    return true
  end
  
  
  def initialize(hash)
    
    raise 'hash must be a hash of valid format' unless self.class.valid_hash?(hash)
    
  end
  
  
end