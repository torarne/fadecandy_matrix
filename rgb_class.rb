#
# Use of a fadecandy driver board to drive a number of 8*8 neopixel boards.
#  - each board is connected to one channel on the fadecandy board, making intricate mapping necessary.
#
# 
#

require 'faderuby'

class FadeRuby::NeoPixelMatrix < FadeRuby::DisplaySurface  
  #
  # Set up a new matrix, giving the width and height in LEDs
  #
  # @param [Fixnum] length number of LEDs
  # 
  def initialize(width = 8, height = 8)
    height.times do
	    width.times do
			pixels.push(FadeRuby::Pixel.new)
		end
    end
#	puts "Initialize NeoPixelMatrix =>" + pixels.inspect
	#      NeoPixelMatrix.pixels[0].set(r: 255, g: 128, b: 0)
    #      NeoPixelMatrix.pixels[1].set(r: 255, g: 128, b: 0)
    #      NeoPixelMatrix.write(NeoPixelMatrix, 1)
  end
  
#  def set_pixels(x,y)
#  end
end

  def socket
    return @s if @s
    @s = TCPSocket.new('127.0.0.1', 7890)
#    @s = TCPSocket.open('127.0.0.1', 7890)
    @s.setsockopt(Socket::IPPROTO_TCP, Socket::TCP_NODELAY, 1)
    return @s
  end



  def set_pixels(colors, channel=0)
    size = (colors.length * 8)
    data = colors.pack('C*')
    header = [channel, 0, data.length].pack('CCS>')
    puts "length =>" + colors.length.to_s
    puts "header =>" + header.inspect
    puts "data =>" + data.inspect
    socket.send header+data, 0
    @s = TCPSocket.new('localhost', 7890)
    @s.print(header+data)
  end



def write_a_x()
	temp = FadeRuby::NeoPixelMatrix.new(8,8)
	temp.set_all(r: 0, g: 255, b: 0)
	temp.pixels[0].set(r: 255, g: 255, b: 255,r: 0, g: 0, b: 0,r: 0, g: 0, b: 0,r: 0, g: 0, b: 0,r: 0, g: 0, b: 0,r: 0, g: 0, b: 0,r: 255, g: 255, b: 255,)
	temp.pixels[1].set(r: 0, g: 0, b: 0,r: 255, g: 255, b: 255,r: 0, g: 0, b: 0,r: 0, g: 0, b: 0,r: 0, g: 0, b: 0,r: 255, g: 255, b: 255,r: 0, g: 0, b: 0,)
	temp.pixels[2].set(r: 0, g: 0, b: 0,r: 0, g: 0, b: 0,r: 255, g: 255, b: 255,r: 0, g: 0, b: 0,r: 255, g: 255, b: 255,r: 0, g: 0, b: 0,r: 0, g: 0, b: 0,)
	temp.pixels[3].set(r: 255, g: 255, b: 255,r: 255, g: 255, b: 255,r: 255, g: 255, b: 255,r: 255, g: 255, b: 255,r: 255, g: 255, b: 255,r: 255, g: 255, b: 255,r: 255, g: 255, b: 255,)
	temp.pixels[4].set(r: 255, g: 255, b: 255,r: 255, g: 255, b: 255,r: 255, g: 255, b: 255,r: 255, g: 255, b: 255,r: 255, g: 255, b: 255,r: 255, g: 255, b: 255,r: 255, g: 255, b: 255,)
	temp.pixels[5].set(r: 255, g: 255, b: 255,r: 255, g: 255, b: 255,r: 255, g: 255, b: 255,r: 255, g: 255, b: 255,r: 255, g: 255, b: 255,r: 255, g: 255, b: 255,r: 255, g: 255, b: 255,)
	temp.pixels[6].set(r: 255, g: 0, b: 0,r: 255, g: 255, b: 255,r: 255, g: 255, b: 255,r: 255, g: 255, b: 255,r: 255, g: 255, b: 255,r: 255, g: 255, b: 255,r: 255, g: 255, b: 255,)
	temp.pixels[7].set(r: 255, g: 255, b: 255,r: 0, g: 0, b: 0,r: 0, g: 0, b: 0,r: 255, g: 255, b: 255,r: 255, g: 255, b: 255,r: 255, g: 255, b: 255,r: 255, g: 255, b: 255,)
	puts "temp =>" + temp.inspect
#	$client.write(temp,1)
    set_pixels(temp.pixels.map(&:to_a).flatten, 0)

end



class RGBColour
  def initialize(red, green, blue)
    unless red.between?(0,255) and green.between?(0,255) and blue.between?(0,255)
      raise ArgumentError, "invalid RGB parameters: #{[red, green, blue].inspect}"
    end
    @red, @green, @blue = red, green, blue
  end
  attr_reader :red, :green, :blue
  alias_method :r, :red
  alias_method :g, :green
  alias_method :b, :blue
 
  RED   = RGBColour.new(255,0,0)
  GREEN = RGBColour.new(0,255,0)
  BLUE  = RGBColour.new(0,0,255)
  BLACK = RGBColour.new(0,0,0)
  WHITE = RGBColour.new(255,255,255)
end
 
class Pixmap
  def initialize(width, height)
    @width = width
    @height = height
    @data = fill(RGBColour::WHITE)
  end
  attr_reader :width, :height
 
  def fill(colour)
    @data = Array.new(@width) {Array.new(@height, colour)}
  end
 
  def validate_pixel(x,y)
    unless x.between?(0, @width-1) and y.between?(0, @height-1)
      raise ArgumentError, "requested pixel (#{x}, #{y}) is outside dimensions of this bitmap"
    end
  end
 
  def [](x,y)
    validate_pixel(x,y)
    @data[x][y]
  end
  alias_method :get_pixel, :[]
 
  def []=(x,y,colour)
    validate_pixel(x,y)
    @data[x][y] = colour
  end
  alias_method :set_pixel, :[]=
end


def buffer_mapping(offset_pointer)
#
# From offsetpointer we need to figure out for each rgb value which channel it's on and send there, in x.mod(8) fashion
#
#
	
end

def write_pixmap_physical_device()
#
# write from our buffer that should map 1<->1 (via a transform) to the LED matrix itself via the fadecandy board.
#	
# 
width = Physical_width
height = Physical_height
width / height = number_of_channels # each Fadecandy has one channel per physical neopixel array, and each pixel array has 64 LED's

channel = 1	# Starting channel (0 is currently being used by other stuff)
x_pointer = 0
y_pointer = 0
face_candy_pointer = 0
while y_pointer < 8 do
	x_pointer = 0
	while x_pointer < 8 do 
		point = pixmap_physical_device[x_pointer, y_pointer]
		client.set_pixels([255,255,255], 1)
end
end		

#
#
#

	
end

physical_width = 8
physical_height = 8
no_of_chars = 10 # each char 7 bits wide + 1 bit ??? (Or variable width- why not?)
pixmap_offscreen = Pixmap.new(no_of_chars * 8, 8) 	# For offscreen drawing
pixmap_physical_device = Pixmap.new(8,8)			# The physical LED matrix size 
offset_pointer = 0	
host = 'localhost'
port = 7890

$client = FadeRuby::Client.new()

# client.set_pixels([0,0,255], 0)
# where the last 0 is the channel number of the fadecandy board	

write_a_x()

# 30 LED strip
#strip = FadeRuby::Strip.new(64)
# Set the whole strip to green
#strip.set_all(r: 255, g: 255, b: 0)
#$client.write(strip,1)
#$client.write(strip,2)
#$client.write(strip,3)
#$client.write(strip,4)
#$client.write(strip,5)
#$client.write(strip,6)
#$client.write(strip,7)
#$client.write(strip,0)

#