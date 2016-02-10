require 'launchy'
class DailyWhatever::CLI
	
	DIVIDER_TOP = "--------------------------------------"
	DIVIDER_BOT = "--------------------------------------\n"
	attr_reader :whatevers, :cur_whatever
	
	def call
		@whatevers = DailyWhatever::WhateverLib.new.whatevers
		puts "\nWHATEVER!"
		random_whatever
	end
	
	def list_whatevers
	end
	
	def random_whatever
		@cur_whatever = get_a_whatever(whatevers.to_a.sample[1])
		display_whatever(cur_whatever)
	end
	
	def get_a_whatever(whatevers_array)
		whatevers_array.sample
	end
	
	def display_whatever(whatever)
		
		puts DIVIDER_TOP
		whatever.hash.each do |k, v|
			puts "#{v}"
		end
		puts DIVIDER_BOT
		display_whatever_instructions
	end
	
	def display_whatever_instructions
		puts "\n=>Type f to follow the link, list to select a whatever library, or press Enter for a new random whatever"
		input = gets.strip
		case input
		when "f"
			cur_whatever.hash[:link] ? Launchy.open(cur_whatever.hash[:link]) : (puts "No link for this one")
			display_whatever_instructions
		else
			random_whatever
		end
	end
	
end