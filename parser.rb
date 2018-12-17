require "./token"
require "./lexer"
require "./func"
require "./variable"

class Parser
    AdditiveOperator = [Token::Plus, Token::Minus]
    MultiplitiveOperator = [Token::Multiply, Token::Devide]
    ModuloOperator = [Token::Modulo, Token::Power]
    BooleanOperator = [Token::Equal, Token::Greater, Token::Less]
    def initialize
        @var_mng = VariableManager.new
    end
    
    def parse(input)
        @lexer = Lexer.new(input)
        first_token = @lexer.next_token()
        if first_token.kind == Token::Variable
            var_name = first_token.name
            if @lexer.next_token().kind == Token::Assign
                return @var_mng.set_name(var_name, operator_add())
            end
        elsif first_token.kind == Token::If
            if operator_boolean()
                raise "Parse Error" if @lexer.next_token().kind != Token::Then
                ret = operator_add()
                raise "Parse Error" if @lexer.next_token().kind != Token::Else
                return ret
            else
                raise "Parse Error" if @lexer.next_token().kind != Token::Then
                skip_while_else()
                return operator_add()
            end
        end
        @lexer.reset()
        operator_add()
    end
    
    def skip_while_else
        token_kind = @lexer.next_token.kind
        while token_kind != Token::Else && token_kind != Token::EndLine
            token_kind = @lexer.next_token.kind
        end
        raise "Parse Error" if token_kind == Token::EndLine
    end
    
    def operator_boolean()
        num1 = operator_add()
        operator = @lexer.next_token().kind
        num2 = operator_add()
        if operator == Token::Equal
            return num1 == num2
        elsif operator == Token::Greater
            return num1 > num2
        elsif operator == Token::Less
            return num1 < num2
        else
            raise "Parse error"
        end
    end
    
    def operator_add
        ret = operator_mul()
        while AdditiveOperator.include?(operator = @lexer.next_token().kind)
            if operator == Token::Plus
                ret += operator_mul()
            else
                ret -= operator_mul()
            end
        end
        @lexer.revert
        return ret
    end
    
    def operator_mul
        ret = operator_pow()
        
        while MultiplitiveOperator.include?(operator = @lexer.next_token().kind)
            if operator == Token::Multiply
                ret *= operator_pow()
            else
                ret /= operator_pow()
            end
        end
        @lexer.revert
        return ret
    end
    
    def operator_pow
        ret = number()
        
        while ModuloOperator.include?(operator = @lexer.next_token().kind)
            if operator == Token::Modulo
                ret = ret % number()
            else
                ret = ret ** number()
            end
        end
        @lexer.revert
        return ret
    end
    
    def number
        ret = @lexer.next_token()
        if ret.kind == Token::Number
            return ret.value
        elsif ret.kind == Token::LeftParen
            ret = operator_add()
            raise "Parse Error" if @lexer.next_token().kind != Token::RightParen
            return ret
        elsif ret.kind == Token::Variable
            return @var_mng.get_name(ret.name)
        elsif ret.kind == Token::Function
            ret = operator_add()
            raise "Parse Error" if @lexer.next_token().kind != Token::RightParen
            return ret
        else
            raise "Parse b   Error"
        end
    end
end

