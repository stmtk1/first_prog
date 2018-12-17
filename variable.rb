class VariableManager
	def initialize
		@names = Hash.new
	end
	
	def set_name(var_name, value)
		raise "already defined" unless @names[var_name].nil?
		@names[var_name] = value
	end
	
	def get_name(var_name)
		raise "not defined" if @names[var_name].nil?
		@names[var_name]
	end
end

