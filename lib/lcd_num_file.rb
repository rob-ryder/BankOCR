require_relative 'lcd_num_row'

class LcdNumFile

  #---class_methods---
  
  def self.valid_file?(file)
    return false unless file.is_a?(File)
    file.each_line do |line|
      return false unless line.match(/^([ _|]{27})?\n*$/)
    end
    file.seek 0
    return true
  end

  #---object_methods---
  
  def initialize(file,lcdNumRowClass=LcdNumRow)
    raise 'file must be a valid instance of File, and must be formatted correctly' unless self.class.valid_file?(file)
    @lcd_rows = []
    line_stack = []
    file.each_line do |line|
      next if line=="\n"
      line_stack << line
      if line_stack.length==3 then
        @lcd_rows << lcdNumRowClass.new({
          :top    => line_stack.shift,
          :middle => line_stack.shift,
          :bottom => line_stack.shift,
        })
      end
    end
    raise 'file not formatted correctly, file ended prematurely' unless line_stack.empty?
  end

  def convert
    string = ''
    @lcd_rows.each do |lcd_row|
      lcd_row_str = lcd_row.to_s
      string << lcd_row_str
      if lcd_row_str.match(/\?+/) then
        string << ' ILL'
      elsif !lcd_row.is_valid_account_num? then
        string << ' ERR'
      end
      string << "\n"
    end
    return string
  end
  
end