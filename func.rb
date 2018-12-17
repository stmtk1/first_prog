class FuncNameManager
    def initialize
        @names = Hash.new
    end
    
    def add_name(func_name, func_behabior)
        raise "already defined" unless @names[func_name].nil?
        @names[func_name] = func_behabior
    end
    
    def get_name(func_name, value)
        raise "not defined" if @names[func_name].nil?
        @name[func_name]
    end
end

