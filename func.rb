class FunctionManager
    def initialize
        @behaviors = Hash.new
        @var_name = Hash.new
        prelude_funcs()
    end
    
    def add_name(func_name, var_name, func_behabior)
        func_name = func_name.strip
        var_name = var_name.strip
        raise "already defined" unless @var_name[func_name].nil?
        @behaviors[func_name] = func_behabior
        @var_name[func_name] = var_name
    end
    
    def get_name(func_name, value)
        raise "not defined" if @var_name[func_name].nil? || @behaviors[func_name].nil?
        parser = Parser.new
        parser.parse("#{@var_name[func_name]} = #{ value }")
        parser.parse(@behaviors[func_name])
    end
    
    def prelude_funcs
        @behaviors["double"] = "a * a" #lambda{|x| Math.sqrt(x) }
        @var_name["double"] = "a" #lambda{|x| Math.sqrt(x) }
    end
end

