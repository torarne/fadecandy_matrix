#// Font definition for LCD 3110 library
#// 5 x 7 font
#// 1 pixel space at left and bottom
#// index = ASCII - 32


puts "started"

#   Exclamation mark
#
#   [0x00, 0x00, 0x2f, 0x00, 0x00]
#
#     00000
#     01000
#	  00000
#     01000
#     01000
#     01000
#     01000

Font_array = [
      [0x00, 0x00, 0x00, 0x00, 0x00] ,   #// sp
      [0x00, 0x00, 0x2f, 0x00, 0x00] ,   #// !
      [0x00, 0x07, 0x00, 0x07, 0x00] ,   #// "
      [0x14, 0x7f, 0x14, 0x7f, 0x14] ,   #// #
      [0x24, 0x2a, 0x7f, 0x2a, 0x12] ,   #// $
      [0x61, 0x66, 0x08, 0x33, 0x43] ,   #// %
      [0x36, 0x49, 0x55, 0x22, 0x50] ,   #// &
      [0x00, 0x05, 0x03, 0x00, 0x00] ,   #// '
      [0x00, 0x1c, 0x22, 0x41, 0x00] ,   #// (
      [0x00, 0x41, 0x22, 0x1c, 0x00] ,   #// )
      [0x14, 0x08, 0x3E, 0x08, 0x14] ,   #// *
      [0x08, 0x08, 0x3E, 0x08, 0x08] ,   #// +
      [0x00, 0x00, 0x50, 0x30, 0x00] ,   #//] ,
      [0x10, 0x10, 0x10, 0x10, 0x10] ,   #// -
      [0x00, 0x60, 0x60, 0x00, 0x00] ,   #// .
      [0x20, 0x10, 0x08, 0x04, 0x02] ,   #// /
      [0x3E, 0x51, 0x49, 0x45, 0x3E] ,   #// 0
      [0x00, 0x42, 0x7F, 0x40, 0x00] ,   #// 1
      [0x42, 0x61, 0x51, 0x49, 0x46] ,   #// 2
      [0x21, 0x41, 0x45, 0x4B, 0x31] ,   #// 3
      [0x18, 0x14, 0x12, 0x7F, 0x10] ,   #// 4
      [0x27, 0x45, 0x45, 0x45, 0x39] ,   #// 5
      [0x3C, 0x4A, 0x49, 0x49, 0x30] ,   #// 6
      [0x01, 0x71, 0x09, 0x05, 0x03] ,   #// 7
      [0x36, 0x49, 0x49, 0x49, 0x36] ,   #// 8
      [0x06, 0x49, 0x49, 0x29, 0x1E] ,   #// 9
      [0x00, 0x36, 0x36, 0x00, 0x00] ,   #// :
      [0x00, 0x56, 0x36, 0x00, 0x00] ,   #// ;
      [0x08, 0x14, 0x22, 0x41, 0x00] ,   #// <
      [0x14, 0x14, 0x14, 0x14, 0x14] ,   #// =
      [0x00, 0x41, 0x22, 0x14, 0x08] ,   #// >
      [0x02, 0x01, 0x51, 0x09, 0x06] ,   #// ?
      [0x32, 0x49, 0x59, 0x51, 0x3E] ,   #// @
      [0x7E, 0x11, 0x11, 0x11, 0x7E] ,   #// A
      [0x7F, 0x49, 0x49, 0x49, 0x36] ,   #// B
      [0x3E, 0x41, 0x41, 0x41, 0x22] ,   #// C
      [0x7F, 0x41, 0x41, 0x22, 0x1C] ,   #// D
      [0x7F, 0x49, 0x49, 0x49, 0x41] ,   #// E
      [0x7F, 0x09, 0x09, 0x09, 0x01] ,   #// F
      [0x3E, 0x41, 0x49, 0x49, 0x7A] ,   #// G
      [0x7F, 0x08, 0x08, 0x08, 0x7F] ,   #// H
      [0x00, 0x41, 0x7F, 0x41, 0x00] ,   #// I
      [0x20, 0x40, 0x41, 0x3F, 0x01] ,   #// J
      [0x7F, 0x08, 0x14, 0x22, 0x41] ,   #// K
      [0x7F, 0x40, 0x40, 0x40, 0x40] ,   #// L
      [0x7F, 0x02, 0x0C, 0x02, 0x7F] ,   #// M
      [0x7F, 0x04, 0x08, 0x10, 0x7F] ,   #// N
      [0x3E, 0x41, 0x41, 0x41, 0x3E] ,   #// O
      [0x7F, 0x09, 0x09, 0x09, 0x06] ,   #// P
      [0x3E, 0x41, 0x51, 0x21, 0x5E] ,   #// Q
      [0x7F, 0x09, 0x19, 0x29, 0x46] ,   #// R
      [0x46, 0x49, 0x49, 0x49, 0x31] ,   #// S
      [0x01, 0x01, 0x7F, 0x01, 0x01] ,   #// T
      [0x3F, 0x40, 0x40, 0x40, 0x3F] ,   #// U
      [0x1F, 0x20, 0x40, 0x20, 0x1F] ,   #// V
      [0x3F, 0x40, 0x38, 0x40, 0x3F] ,   #// W
      [0x63, 0x14, 0x08, 0x14, 0x63] ,   #// X
      [0x07, 0x08, 0x70, 0x08, 0x07] ,   #// Y
      [0x61, 0x51, 0x49, 0x45, 0x43] ,   #// Z
      [0x00, 0x7F, 0x41, 0x41, 0x00] ,   #// [
      [0x55, 0x2A, 0x55, 0x2A, 0x55] ,   #// checker pattern
      [0x00, 0x41, 0x41, 0x7F, 0x00] ,   #// ]
      [0x04, 0x02, 0x01, 0x02, 0x04] ,   #// ^
      [0x40, 0x40, 0x40, 0x40, 0x40] ,   #// _
      [0x00, 0x01, 0x02, 0x04, 0x00] ,   #// '
      [0x20, 0x54, 0x54, 0x54, 0x78] ,   #// a
      [0x7F, 0x48, 0x44, 0x44, 0x38] ,   #// b
      [0x38, 0x44, 0x44, 0x44, 0x20] ,   #// c
      [0x38, 0x44, 0x44, 0x48, 0x7F] ,   #// d
      [0x38, 0x54, 0x54, 0x54, 0x18] ,   #// e
      [0x08, 0x7E, 0x09, 0x01, 0x02] ,   #// f
      [0x0C, 0x52, 0x52, 0x52, 0x3E] ,   #// g
      [0x7F, 0x08, 0x04, 0x04, 0x78] ,   #// h
      [0x00, 0x44, 0x7D, 0x40, 0x00] ,   #// i
      [0x20, 0x40, 0x44, 0x3D, 0x00] ,   #// j
      [0x7F, 0x10, 0x28, 0x44, 0x00] ,   #// k
      [0x00, 0x41, 0x7F, 0x40, 0x00] ,   #// l
      [0x7C, 0x04, 0x18, 0x04, 0x78] ,   #// m
      [0x7C, 0x08, 0x04, 0x04, 0x78] ,   #// n
      [0x38, 0x44, 0x44, 0x44, 0x38] ,   #// o
      [0x7C, 0x14, 0x14, 0x14, 0x08] ,   #// p
      [0x08, 0x14, 0x14, 0x18, 0x7C] ,   #// q
      [0x7C, 0x08, 0x04, 0x04, 0x08] ,   #// r
      [0x48, 0x54, 0x54, 0x54, 0x20] ,   #// s
      [0x04, 0x3F, 0x44, 0x40, 0x20] ,   #// t
      [0x3C, 0x40, 0x40, 0x20, 0x7C] ,   #// u
      [0x1C, 0x20, 0x40, 0x20, 0x1C] ,   #// v
      [0x3C, 0x40, 0x30, 0x40, 0x3C] ,   #// w
      [0x44, 0x28, 0x10, 0x28, 0x44] ,   #// x
      [0x0C, 0x50, 0x50, 0x50, 0x3C] ,   #// y
      [0x44, 0x64, 0x54, 0x4C, 0x44] ,   #// z
      [0x00, 0x06, 0x09, 0x09, 0x06]     #// Degree symbol
]


#def char_to_8_8(tegn)
#
# Take a matrix row of 5 cells and turn it into a 8*8 matrix
#  do this by leaving the first and last column zero filled
#

#
      matrix_8_8 = [
      			[0,0,0,0,0,0,0,0],
      			[0,0,0,0,0,0,0,0],
	  			[0,0,0,0,0,0,0,0],
	  			[0,0,0,0,0,0,0,0],
	  			[0,0,0,0,0,0,0,0],
	  			[0,0,0,0,0,0,0,0],
	  			[0,0,0,0,0,0,0,0],
	  			[0,0,0,0,0,0,0,0]
      ]
      
      
def binary_to_array(inn_streng)
	array_temp = []
	while inn_streng.length < 8 do
	 inn_streng = "0" + inn_streng
	end
	for i in 0..7 do
	 array_temp[7 - i]= inn_streng[i].to_i
	end
#	puts "binary_to_arrow =>" + array_temp.inspect
	return array_temp
end



# streng = "A"
# heltall = streng.ord
# binary_streng = heltall.to_s(2)

tegn = " "

def draw_tegn(tegn)
	font_array = Font_array
	tegn_nr = font_array[tegn.ord - 32]
#	puts "Tegn ->"+ tegn.to_s 
#	puts "Tegn_nr =>" + tegn.ord.to_s
#	puts "tegn_array ->" + tegn_nr.to_s
	x = tegn_nr
#	x = [0x00, 0x00, 0x2f, 0x00, 0x00]
#	row_integer = font(tegn - '')
	matrix = [
      			[0,0,0,0,0,0,0,0],
      			[0,0,0,0,0,0,0,0],
	  			[0,0,0,0,0,0,0,0],
	  			[0,0,0,0,0,0,0,0],
	  			[0,0,0,0,0,0,0,0],
	  			[0,0,0,0,0,0,0,0],
	  			[0,0,0,0,0,0,0,0],
	  			[0,0,0,0,0,0,0,0]
      ]

	matrix[7] = binary_to_array(x[0].to_s(2).to_s)
	matrix[6] = binary_to_array(x[1].to_s(2).to_s)
	matrix[5] = binary_to_array(x[2].to_s(2).to_s)
	matrix[4] = binary_to_array(x[3].to_s(2).to_s)
	matrix[3] = binary_to_array(x[4].to_s(2).to_s)
	matrix[2] = binary_to_array("")
	matrix[1] = binary_to_array("")
	matrix[0] = binary_to_array("")
	
# The following seems to give us a understandable matreix for adding on to on the right.
	puts "matrix.reverse.transpose =>" + matrix.reverse.transpose.inspect # This seems to give us a responable array.
	matrix = matrix.reverse.transpose

# This is the riginal
#	matrix = matrix.transpose.transpose.reverse
#	puts "matrix.transpose.transpose.reverse  =>" + matrix.inspect

	return matrix
end


def debug_print_matrix(matrise,big_matrise)
	puts "matrise =>"
	matrise.each do |linje|
		puts linje.inspect	
	end
	puts matrise.inspect
	puts "big_matrise =>"
	big_matrise.each do |linje|
		puts linje.inspect	
	end
	
end

def debug_1_matrix(matrise)
	if $debug == true then
		puts "1matrise =>"
		matrise.reverse.each do |linje|
			puts linje.inspect	
		end
	end
end


def draw_streng(streng)
#
# Draw_streng will call draw_tegn multiple times - returning a 8*8 matrix each time, but 
#  remembering that the character sits in a 5*7 cell so we need to remove the last column and add the rest?
#
# In Ruby 2 array can be concatenated by z.concat y where z is now extended by y or b = y + z
#
#
#
#
	@width = 8
	@height = 8
	
	big_matrix = Array.new(@width) {Array.new(@height)}
#	puts "big_matrix = >" + big_matrix.inspect
	small_matrix = Array.new(@width) {Array.new(@height)}
	loop_counter = 0
	streng.each_char do |tegn|
		small_matrix = draw_tegn(tegn)
		if loop_counter == 0 then
			big_matrix = small_matrix	
		end
		if loop_counter != 0 then
			8.times do |teller|
				lengde = big_matrix[teller].length - 3
				puts lengde.to_s
				big_matrix[teller] = big_matrix[teller][0..lengde] + small_matrix[teller]
			end
		end 
#		puts "small_matrix =>" + small_matrix.inspect
		loop_counter = loop_counter + 1
		debug_print_matrix(small_matrix, big_matrix)
#		puts(tegn)
	end	
	return big_matrix
end



#	def draw_tegn_offset(tegn,x_offset,y_offset)
#		for tegn in '!'..'z' do
#			matrix_tegn = draw_tegn(tegn)
#			for x in 0..7
#					for y in 0..7 
#						led.write_pixel(matrix_tegn[y][x],x,y,false)
#					end
#				end
#			led.write_pixel(matrix_tegn[y][x],x,y,true)
#		end
#	end
	
	

