class Address < Record
  # def initialize content
  #   super content
  #   street_rgx = /Ave|St|Blvd|Rd|Ct/
  #   street_split = @content.split(', ')
  #   @street = components[0]
  #   @city = components[1]
  #   # area = components[1]
  #   # city_state = area.split(', ')
  #   # @city = city_state[0]
  #   # @state = city_state[1]
  #   # @zip = city_state[1].split(' ')
  # end

  def initialize address
    @address = address
    street_rgx = /Ave|St|Blvd|Rd|Ct/
    street_split = @address.split(street_rgx)
    @street = street_split[0]
    @appendix = street_rgx.match(@address)
    area = street_split[1]
    city_state = area.split(', ')
    @city = city_state[0].gsub(/^(.*)\s/,'')
    @state = city_state[1].split(' ')[0]
    @zip = city_state[1].split(' ')[1]
  end

  def format
    "#{@street}#{@appendix}\n#{@city}, #{@state} #{@zip}"
  end
end
