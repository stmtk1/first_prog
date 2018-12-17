class Token
    Plus =         1
    Minus =        2
    Multiply =     3
    Devide =       4
    LeftParen =    5
    RightParen =   6
    Power =        7
    Modulo =       8
    Number =       9
    Variable =    10
    Assign =      11
    Function =    12
    If =          14
    Then =        15
    Else =        16
    End =         17
    Equal =       18
    Greater =     19
    Less =        20
    EndLine =     21

    attr_reader :kind
    attr_accessor :value, :name
    def initialize(kind)
        @kind = kind
    end
end

class NumberToken < Token
    attr_reader :value
    def initialize(value)
        @kind = Token::Number
        @value = value
    end
end

class FunctiuonToken < Token
    attr_reader :name
    def initialize(name)
        @kind = Token::Function
        @name = name
    end
end

class VariableToken < Token
    attr_reader :name
    def initialize(name)
        @kind = Token::Variable
        @name = name
    end
end
