class AccountNumberInterpreter

  def interpret_file(file)
    
    #validate parameters
    raise "File given is not a valid instance of ::File" unless file.is_a?(::File)
    
    #set up arrays used for processing
    raw_lines = []
    linearized_lines = []
    interpreted_lines = []
    
    #loop through file lines, linearizing and interpreting
    file.each do |line|
      if (raw_lines.length==0 && (line=="\n" || line=='')) then
        next
      end
      raw_lines << line
      if raw_lines.length==3 then
        upper_line = raw_lines.shift
        middle_line = raw_lines.shift
        lower_line = raw_lines.shift
        linearized_lines << linearize_line_set(upper_line, middle_line, lower_line)
        interpreted_lines << interpret_linear_line(linearized_lines.last)
      end
    end
    
    #return the result as a string
    interpreted_lines.join("\n")
    
  end
  
  private
  
  def linearize_line_set(upper_line, middle_line, lower_line)
    
    #break up the lines into chunks, validate resulting sizes
    upper_line_chunks  = upper_line.scan(/.{3}/)
    middle_line_chunks = middle_line.scan(/.{3}/)
    lower_line_chunks  = lower_line.scan(/.{3}/)
    if upper_line_chunks.length!=9 || middle_line_chunks.length!=9 || lower_line_chunks.length!=9 then
      raise "Could not linearize line set, one or more lines had an invalid character count."
    end
    
    #concatinate chunks into linearized lines
    linearized_line = []
    9.times do |i|
      linearized_line[i] = upper_line_chunks[i] + middle_line_chunks[i] + lower_line_chunks[i];
    end
    
    #return the linearized line
    linearized_line
    
  end
  
  def interpret_linear_line(line)
    
    #define new line string
    interpreted_line = ''
    
    #calc actual number for each led number signature (top line symbols + mid line symbols + bottom line symbols)
    line.each do |led_signature|
      interpreted_line << identify_led_signature(led_signature).to_s
    end
    
    #return interpreted line string
    interpreted_line
    
  end
  
  def identify_led_signature(signature)
    fetch_signature_map.each do |actual,test_signature|
      return actual if signature==test_signature
    end
    raise "Could not identify led signature, file may not be valid."
  end
  
  def fetch_signature_map
    {
        0 => ' _ | ||_|',
        1 => '     |  |',
        2 => ' _  _||_ ',
        3 => ' _  _| _|',
        4 => '   |_|  |',
        5 => ' _ |_  _|',
        6 => ' _ |_ |_|',
        7 => ' _   |  |',
        8 => ' _ |_||_|',
        9 => ' _ |_| _|',
    }
  end

end