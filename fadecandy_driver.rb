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
require "./opc.rb"



#
#tid = Time.now.strftime("%S")
object = Opc.new()
puts object.getsecond
object.connect('127.0.0.1',7890)
object.init(60)
object.sendfirmwareconfig(3)
object.buildheader(0)

def test(object)
  object.setalldata($brightness)
  sleep(3)
  object.setalldata(0)
  sleep(3)
  object.setalldata($brightness)
  #object.demoseconds()
  puts "Start moving"
  width = 
  r = $brightness
  g = $brightness
  b = $brightness
  pointer = 0
  #buffer = zero_filled_buffer(true, true, true)
  while pointer < 6 do
    object.set_pixel_range(pointer, 1, r,256,256)
    object.set_pixel_range(pointer, 2, 256,$brightness,256)
    object.set_pixel_range(pointer, 3, 256,256,$brightness)
    object.printpacketdata
    puts "##"
  
    pointer = pointer + 1
    sleep(1)
  end
end



#test(object)


# This is cheating a bit - but it seems to work
# Just sleep for one second every round - then for each of the "hands" pick up the time from the
#  operating system to make sure we use the correct time
while true != false do
  puts "second loop" + Time.now.strftime("%l:%M:%S")
  object.setsecond
  object.setminute
  object.sethour
  sleep(1)
end
