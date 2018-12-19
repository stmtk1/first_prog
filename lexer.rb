require "./token"

class Lexer
    PlusPattern = /^\s*\+/
    MinusPattern = /^\s*\-/
    MultiplyPattern = /^\s*\*/
    DevidePattern = /^\s*\//
    LeftParenPattern = /^\s*\(/
    RightParenPattern = /^\s*\)/
    PowerPattern = /^\s*\^/
    ModuloPattern = /^\s*%/
    NumberPattern = /^\s*\d+(\.\d+)?/
    FunctionPattern = /^\s*\w[\w\d_]*\(/
    DefunPattern = /^\s*defun/
    VariablePattern = /^\s*\w[\w\d_]*/
    AssignPattern = /^\s*\=/
    IfPattern = /^\s*if /
    ThenPattern = /^\s*then /
    ElsePattern = /^\s*else /
    EqualPattern = /^\s*\=\=/
    GreaterPattern = /^\s*>/
    LessPattern = /^\s*</
    EndLinePattern = /^\s*$/
    def initialize(input)
        @first_string = @analized_string = input
    end
    
    def next_token
        if @return_previous_token
            @return_previous_token = false
            return @previous_token
        end
        
        case @analized_string
        when Lexer::PlusPattern
            token = Token.new(Token::Plus)
        when Lexer::MinusPattern
            token = Token.new(Token::Minus)
        when Lexer::MultiplyPattern
            token = Token.new(Token::Multiply)
        when Lexer::DevidePattern
            token = Token.new(Token::Devide)
        when Lexer::RightParenPattern
            token = Token.new(Token::RightParen)
        when Lexer::LeftParenPattern
            token = Token.new(Token::LeftParen)
        when Lexer::PowerPattern
            token = Token.new(Token::Power)
        when Lexer::ModuloPattern
            token = Token.new(Token::Modulo)
        when Lexer::NumberPattern
            token = Token.new(Token::Number)
            token.value = $&.to_f
        when Lexer::FunctionPattern
            token = FunctionToken.new($&)
        when Lexer::DefunPattern
            token = Token.new(Token::Defun)
        when Lexer::IfPattern
            token = Token.new(Token::If)
        when Lexer::ThenPattern
            token = Token.new(Token::Then)
        when Lexer::ElsePattern
            token = Token.new(Token::Else)
        when Lexer::EqualPattern
            token = Token.new(Token::Equal)
        when Lexer::GreaterPattern
            token = Token.new(Token::Greater)
        when Lexer::LessPattern
            token = Token.new(Token::Less)
        when Lexer::AssignPattern
            token = Token.new(Token::Assign)
        when Lexer::EndLinePattern
            token = Token.new(Token::EndLine)
        when Lexer::VariablePattern
            token = VariableToken.new($&)
        else
            raise "Parse Error"
        end
        @analized_string = $'
        return @previous_token = token
    end
    
    def revert
        @return_previous_token = true
    end
    
    def reset
        @analized_string = @first_string
        @return_previous_token = false
    end
    
    def get_rest_all
        @analized_string
    end
end

