#
# Use of a fadecandy driver board to drive a number of 8*8 neopixel boards.
#  - each board is connected to one channel on the fadecandy board, making intricate mapping necessary.
#
# 19042015 - this is a very early version
#
# Not written to be a example of expert Ruby programming, but to teach myself a few principles of programmeing, and to eb able to read them afterwards
#

require 'faderuby'
require './opc.rb'
require './font.rb'
require 'time'

$debug = false  # Turns debugging output to terminal on and off

$header = ""

$channel = 1
$channel1 = 2

@object = Opc.new()
@object.connect('127.0.0.1',7890)
@object.init(64)
@object.sendfirmwareconfig(2)
$header = @object.buildheader($channel)
@font_width = 5
@font_height = 7





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
#    puts "length =>" + colors.length.to_s
#    puts "header =>" + header.inspect
#    puts "data =>" + data.inspect
    socket.send header+data, 0
    @s = TCPSocket.new('localhost', 7890)
    @s.print(header+data)
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



def test_buffer()
	test = Array.new[8]	

end


def slice_matrix(matrise,offset)
#
# Slice a 8*8 matrix out of a much longer virtual matrix, starting at offset
#
	small_matrix = Array.new(@width) {Array.new(@height)}
	teller = 0
	8.times do
		small_matrix[teller] = matrise[teller][offset..(offset + 8)]
		teller = teller + 1
	end
	return small_matrix	
end



def write_pixmap_physical_device(matr,offset = 0,kanal)
#
# write from our buffer that should map 1<->1 (via a transform) to the LED matrix itself via the fadecandy board.
#	
# offset is the where on the x-axis we should start the physical window into the matrix matr
#
	width = 8
	height = 8
	number_of_channels = width / height  # each Fadecandy has one channel per physical neopixel array, and each pixel array has 64 LED's
	temp = FadeRuby::NeoPixelMatrix.new(width,height)
	temp.set_all(r: 0, g: 0, b: 0)
#	puts "matr =>" + matr.inspect
	
	small_matrix = slice_matrix(matr,offset)
	debug_1_matrix(small_matrix)

	x_pointer = 0
	y_pointer = 0
	face_candy_pointer = 0
		while y_pointer < height do
			x_pointer = 0
			while x_pointer < (width) do 
				if small_matrix[y_pointer][x_pointer] != 0 then
					temp.pixels[y_pointer + (x_pointer * 8)].set(r: 128, g: 128, b: 128)
				elsif
					temp.pixels[y_pointer + (x_pointer * 8)].set(r: 0, g: 0, b: 0)				
				end
				x_pointer = x_pointer + 1
			end
			y_pointer = y_pointer + 1
		end
	tempo = []
	teller = 0
	
	
	temp.pixels.each do |pixie|
		tempo[teller] =  pixie.r
		tempo[teller + 2] = pixie.b
		tempo[teller+1] =  pixie.g
		teller = teller + 3
	end
	
	temp3 = tempo.pack("C*")
#	puts "temp3.2 =>" 
    @object.write_pixel_buffer(@object.buildheader(kanal) + temp3) 
end		

#
#
#


physical_width = 8
physical_height = 8
no_of_chars = 10 # each char 7 bits wide + 1 bit ??? (Or variable width- why not?)
pixmap_offscreen = Pixmap.new(no_of_chars * 8, 8) 	# For offscreen drawing
pixmap_physical_device = Pixmap.new(8,8)			# The physical LED matrix size 
offset_pointer = 0	
host = 'localhost'
port = 7890


$client = FadeRuby::Client.new()

tid = Time.now.strftime("%l:%M:%S")

# client.set_pixels([0,0,255], 0)
# where the last 0 is the channel number of the fadecandy board	

#matrix = draw_tegn("R") # returns a 8*8 matrix with the character in it
matrix = draw_streng("Testing " + tid + " ") # returns a 8*(font_width + 1) matrix with the character in it
#puts "matrix =>" + matrix.inspect
matrix = matrix.reverse
write_pixmap_physical_device(matrix,0)
offset = 0
while offset < (matrix[0].length - 8) do
#	puts "offset =>" + offset.to_s
#	write_pixmap_physical_device(matrix,offset)
#	sleep(0.15)
	offset = offset + 1
end

while true != false do
	tid = Time.now.strftime("%H:%M:%S")
	matrix = draw_streng("  " + tid + "   ")
	matrix = matrix.reverse
	offset = 0
	while offset < (matrix[0].length - 16) do
		write_pixmap_physical_device(matrix,offset,$channel)
		write_pixmap_physical_device(matrix,offset + 8,$channel1)
		sleep(0.14)
		offset = offset + 1
	end
	sleep(1)
end


#