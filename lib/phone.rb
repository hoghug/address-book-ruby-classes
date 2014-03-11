class Phone
  def initialize(number)
    @number = number
  end

  def format
    number_string = @number.to_s
    format_string = '('
    format_string += number_string[0,3]
    format_string += ') ' + number_string[3,3] + '-' + number_string[6,4]
    format_string
  end
end
