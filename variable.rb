class VariableManager
    def initialize
        @names = Hash.new
    end
    
    def set_name(var_name, value)
        @names[var_name.strip] = value
    end
    
    def get_name(var_name)
        raise "not defined" if @names[var_name.strip].nil?
        @names[var_name.strip]
    end
end

