#
#  05052014 - Tor 
# - Ruby functions to use a Fadecandy board with a AdaFruit 60 pixel circle
#   as a clock.
# - This library communicates with a Fadecandy board through a FCserver running 
#   on a locak computer - or a Raspberry Pi
#
# Some functions to set ranges of pixels as RGB colours
#
#
#   Firmware packet
#byte[] packet = new byte[9];
#packet[0] = 0;          // Channel (reserved)
#packet[1] = (byte)0xFF; // Command (System Exclusive)
#packet[2] = 0;          // Length high byte
#packet[3] = 5;          // Length low byte
#packet[4] = 0x00;       // System ID high byte
#packet[5] = 0x01;       // System ID low byte
#packet[6] = 0x00;       // Command ID high byte
#packet[7] = 0x02;       // Command ID low byte
#packet[8] = firmwareConfig;
#
#

require 'socket'




# Public class OPC to align with other languages
class Opc

@@output
@@packetdata = ""       # This is the full packet with all data for all pixels
@@temp_packetdata = ""       # This is the full packet with all data for all pixels
@@packetheader = "" # The standard 
@@numpixels = 60

$brightness = 12	# To let us gobally dim all pixels/light - possibly from a LDR sensor?

# For debugging  
def printpacketdata
  puts "@@packetdata =>" + @@packetdata.bytes.to_s
end
  

def sendfirmwareconfig(firmwareconfig)
  # bit 1 = Disable keyframe interpolation
  # bit 0 = Disable dithering
  packet = String.new
  packet = "    "
  temp = [0]
  packet[0] = temp.pack("C")
  temp = [255]
  packet[1] = temp.pack("C")
  temp = [0]
  packet[2] = temp.pack("C")
  temp = [5] # length of data not including the 4 first bytes. Remmber in one byte diw by 3
  packet[3] = temp.pack("C")
  temp = [0]
  packet[4] = temp.pack("C")
  temp = [1]
  packet[5] = temp.pack("C")
  temp = [0]
  packet[6] = temp.pack("C")
  temp = [2]
  packet[7] = temp.pack("C")
  temp = [firmwareconfig.to_i]
  packet[8] = temp.pack("C")
  @@output.print(packet)
  @@output.flush  
  puts "packetdata firmware config =>" + @@packetdata.bytes.to_s
  puts "---"
  puts "Sent firmware config =>" + firmwareconfig.to_s  
end







# This is a quick demo function sets all pixels to same brightness
def setalldata(inndata)
  size = @@numpixels * 3 # Number of LED's times the number of colours per LED (3)
#  puts "size 1 =>" + size.to_s
  puts "Set all data to =>" + inndata.to_s
  @@temp_packetdata = String.new
  @@temp_packetdata = "    "
  temp = [0]
  @@temp_packetdata[0] = temp.pack("C")
  @@temp_packetdata[1] = temp.pack("C")
  @@temp_packetdata[2] = temp.pack("C")
  packetlen = [size]
  @@temp_packetdata[3] = packetlen.pack("C")
  i = 4
  t = -1
  temp = [inndata,inndata,inndata] 
#  temp = [128,128,128] # something is wrong - this is a array
 puts "Inndata ->" + temp.inspect
  until t >= (size - 1) do 
    t = t + 1
    puts t
    @@temp_packetdata[i + t] = temp.pack("C")
  end
  puts "Size =>" + @@temp_packetdata.size.to_s
  puts "setalldata =>" + @@temp_packetdata.bytes.to_s
  @@output.print(@@temp_packetdata)
end


def buildheader(channel = 0)
  @size = @@numpixels * 3 # Number of LED's times the number of colours per LED (3)
  if $debug == true then
  	puts "@size =>" + @size.to_s
  end
  temp = [channel]
  @@packetheader[0] = temp.pack("C")

  temp = [0]
  @@packetheader[1] = temp.pack("C")
  @@packetheader[2] = temp.pack("C")
  packetlen = [@size]
  @@packetheader[3] = packetlen.pack("C")  
#  puts "@@packetheader =>" + @@packetheader.inspect 
  return @@packetheader
end


def write_pixel_buffer(total)
#	puts "Total =>" + total.inspect
#	puts "Total length" + total.length.to_s
  @@output.print(total) 
#  puts"-" 
#  puts total.bytes.to_s
end

def getsecond
  return Time.now.strftime("%S")
end

def getminute
  return Time.now.strftime("%M")
end

def gethour  
  return Time.now.strftime("%l")
end

def setsecond
  sec = getsecond
#  set_pixel_range(sec.to_i, 1, 255,256,256)
  set_pixel_range(0,sec.to_i, 155,256,256)
end

def setminute
  min = getminute
#  set_pixel_range(min.to_i,1,256,255,256)
  set_pixel_range(0, min.to_i,256,155,256)
end

def sethour
  hour = gethour.to_i
  set_pixel_range((hour.to_i * 5)- 2,5,256,256,255)
end


# Take the buffer and set one pixel (3 bytes) in the existing buffer
#
# - if any or r,g,b is set to larger than 255 do not set or change that colour 
#
# TODO - if pixelno >= @@numpixels do modulo
#
def set_one_pixel(pixelno,r,g,b)
#  puts "Set one pixel length packetdata in " + @@packetdata.size.to_s
  pixelno = pixelno % @@numpixels
  if r < 256 then
    temp = [r]
    @@packetdata[pixelno * 3] = temp.pack("C")
  end
  if g < 256 then
    temp = [g]
    @@packetdata[(pixelno * 3) + 1] = temp.pack("C")
  end
  if b < 256 then
    temp = [b]
    @@packetdata[(pixelno * 3) + 2] = temp.pack("C") 
  end 
end

  
def setpixel(pixelno, brightness)
  buildheader()
  buffer = String.new
  zero_data = [0,0,0]
  bright = [brightness.to_i]
  pixel_no = 0
  while pixel_no < 24 do
    offset = pixel_no * 3
    buffer[offset] = zero_data.pack("CCC")
#    puts "buffer Packetdata length =>" + buffer.size.to_s
    pixel_no = pixel_no + 1
  end
#  puts "buffer = >" + buffer.bytes.to_s
#  puts "buffer Packetdata length =>" + buffer.size.to_s
  buffer[pixelno * 3] = bright.pack("C")
  buffer[(pixelno * 3) + 1] = bright.pack("C")
  buffer[(pixelno * 3) + 2] = bright.pack("C")
#  puts "buffer = >" + buffer.bytes.to_s
  total = @@packetheader + buffer
#  puts "total =>" + total.bytes.to_s
  write_pixel_buffer(total)
#  puts "buffer Packetdata length =>" + buffer.size.to_s
#  puts "@@Packetdata length =>" + @@packetdata.size.to_s
#  puts "Total Packetdata length =>" + total.size.to_sw 
end




# Set a number of pixels of one or more colours to a value, and all others set to zero
# - for moving one or more pixels of colour around a circle
# works with set_one_pixel over the width (number of) of the coloured pixels - assumed to be RGB
#
# Setting any of the RGB values > 255 means "do not change anything that's there"
#
# TODO : when width > 1 use modulo to make sure the pixels in the ring are correct.
#
def set_pixel_range(offset, width, r,g,b)
  # Generate a new - zero filled buffer string
  # But just for colours <
    buffer = zero_filled_buffer(r, g, b)
   #copy across the offset * width pixels from the original buffer string
  pointer = offset * 3
#  puts "offset =>" + offset.to_s
#  puts "width =>" + width.to_s
#  puts "buffer =>" + buffer.bytes.to_s
#  puts "@@packetdata =>" + @@packetdata.bytes.to_s
  while pointer.to_i < (offset.to_i + (width.to_i * 3))
    buffer[pointer.to_i] = @@packetdata[pointer.to_i]
    pointer = pointer + 1
  end
  @@packetdata = buffer
# set the required new pixels
#  puts "@@packetdata before set_one_pixel =>" + @@packetdata.bytes.to_s
  pointer = offset
  while pointer.to_i < (offset.to_i + (width))
    set_one_pixel(pointer,r,g,b)
    pointer = pointer + 1
  end 
#  puts "header + @@packetdata  =>" + buildheader + "-"+ @@packetdata.bytes.to_s
  write_pixel_buffer(buildheader + @@packetdata) 
end



def demominute
  set_one_pixel((t.to_i - 1)%@@numpixels ,256,0,256)
  set_one_pixel(t,256,$brightness,256)  
end



def demoseconds
  t = 0
  previous_t = @@numpixels - 1
  buildheader()
  while true!=false do
    while t < @@numpixels do
      set_one_pixel(t,$brightness,256,256)
      set_one_pixel(previous_t,0,256,256)
      total = @@packetheader + @@packetdata
      puts "Length =>" + total.size.to_s
      write_pixel_buffer(total)
      puts "set_one_pixel"
      sleep(60 / @@numpixels)
      previous_t = t
      t = t + 1
    end
    t = 0
    previous_t = @@numpixels -1
    demominute
  end
end




def set_time
  while true != false do
    set_second(getseconds)
    set_minutes(getminute)
    set_hour(gethour)
    sleep(60 / @@numpixels)
  end
end



# Fill a buffer with zeros, individually per colour
def zero_filled_buffer(r,g,b)
  buffer = @@packetdata
  i = 0
  p = [0.to_i]
  i = 0
  p = [0.to_i]
  while i < (@@numpixels * 3)
    if r < 256 then
      buffer[i] = p.pack("C")
    end
    i = i + 1
    if g < 256 then
      buffer[i] = p.pack("C")
    end
    i = i + 1
    if b < 256 then
      buffer[i] = p.pack("C")
    end
    i = i + 1
  end
  return buffer
end

  
#
# Set up the databuffer - initialize to zeroes
#  
def init(num_of_pixels)
  @@packetdata = String.new
  @@numpixels = num_of_pixels 
  i = 0
  p = [0.to_i]
  while i < (@@numpixels * 3)
    @@packetdata[i] = p.pack("C")
    i = i + 1
  end
end
  


  def connect(hostname, port)
    @@output = TCPSocket.open(hostname, port)
#    @@output = socket
    #socket.puts()
    puts "Open socket to fcserver" 
  end
    
end
