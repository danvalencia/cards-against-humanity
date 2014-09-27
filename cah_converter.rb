require 'rmagick'
require 'rtesseract'
require 'pathname'

x_initial_offset = 80
y_initial_offset = 110
card_width = 600
card_height = 600
num_cols = 4
num_rows = 5

if ARGV.count > 2
  image_dir = ARGV[0]
  file_name = ARGV[1]
  is_question_card = ARGV[2] == 'true' ? true : false
else
  puts "Usage: ./cah_converter <image-directory> <file-name> <is-question-card>"
  exit 1
end

images = `ls #{image_dir}`.split $\

def process_question_card(card)
  card = card.gsub(/\n\n‘i.*/, '').gsub(/[FI]\..*/, '').gsub(/\n/, ' ').strip
end

def process_answer_card(card)
  card.gsub(/\n\n‘i.*/, '').gsub(/‘F.*/, '').gsub(/\n/, ' ').strip
end

images.each do |img|
  img_abs_path = Pathname.new("#{image_dir}/#{img}").realpath.to_s
  puts "Processing Image: #{img_abs_path}"
  end_row = num_rows - 1
  end_col = num_cols - 1
  for n in 0..end_row
    y_offset = y_initial_offset  + (card_height * n)
    for n in 0..end_col
      x_offset = x_initial_offset  + (card_width * n)
      puts "     Processing card at location: (#{x_offset},#{y_offset})"

	  mix_block = RTesseract::Mixed.new(img_abs_path) do |i|
        i.area(x_offset, y_offset, card_width, card_height)
	  end

	  if is_question_card
	    card_text = process_answer_card(mix_block.to_s)
	  else
	    card_text = process_question_card(mix_block.to_s)	
	  end

	  puts "             Card Text: #{card_text}"

	  File.open(file_name, "a") do |f|
	  	f.puts card_text
	  end
    end
  end

end

