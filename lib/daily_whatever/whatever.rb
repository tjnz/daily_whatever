class DailyWhatever::Whatever
	
	#attr_accessor :author, :text, :link
	# dynamic attr_accessors
	#http://stackoverflow.com/questions/4964179/how-do-i-set-an-attr-accessor-for-a-dynamic-instance-variable
	
	attr_accessor :hash
	
	def initialize(hash)
		@hash = hash
	end
		
end