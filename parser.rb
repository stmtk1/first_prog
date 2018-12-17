require "./token"
require "./lexer"
require "./func"
require "./variable"

class Parser
	AdditiveOperator = [Token::Plus, Token::Minus]
	MultiplitiveOperator = [Token::Multiply, Token::Devide]
	ModuloOperator = [Token::Modulo, Token::Power]
	def initialize
		@var_mng = VariableManager.new
	end
	
	def parse(input)
		@lexer = Lexer.new(input)
		first_token = @lexer.next_token()
		if first_token.kind == Token::Variable
			var_name = first_token.name
			if @lexer.next_token().kind == Token::Equal
			return (p @var_mng.set_name(var_name, operator_add()))
			end
		end
		@lexer.reset()
		p operator_add()
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

