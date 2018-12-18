class FunctionManager
    def initialize
        @names = Hash.new
        prelude_funcs()
    end
    
    def add_name(func_name, func_behabior)
        raise "already defined" unless @names[func_name].nil?
        @names[func_name] = func_behabior
    end
    
    def get_name(func_name, value)
        raise "not defined" if @names[func_name].nil?
        @names[func_name].call(value)
    end
    
    def prelude_funcs
        @names["sqrt"] = lambda{|x| Math.sqrt(x) }
    end
end

