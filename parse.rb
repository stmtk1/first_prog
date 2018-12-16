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

class Token
	Plus = 		1
	Minus = 	2
	Multiply = 	3
	Devide = 	4
	LeftParen = 	5
	RightParen = 	6
	Power =	 	7
	Modulo = 	8
	Number = 	9
	Function = 	10
	End =	 	11

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
		@kind = Token::Number
		@name = name
	end
end


class Lexer
	PlusPattern = /^\s*\+/
	MinusPattern = /^\s*\-/
	MultiplyPattern = /^\s*\*/
	DevidePattern = /^\s*\//
	LeftParenPattern = /^\s*\(/
	RightParenPattern = /^\s*\)/
	PowerPattern = /^\s*\^/
	ModuloPattern = /^\s*%/
	NumberPattern = /^\s*\d+/
	FunctionPattern = /^\s*\w[\w\d_]*\(/
	EndPattern = /^\s*$/
	def initialize(input)
		@analized_string = input
	end
	
	def next_token
		if @return_previous_token
			@return_previous_token = false
			return @previous_token
		end
		
		if Lexer::PlusPattern.match(@analized_string)
			token = Token.new(Token::Plus)
		elsif Lexer::MinusPattern.match(@analized_string)
			token = Token.new(Token::Minus)
		elsif Lexer::MultiplyPattern.match(@analized_string)
			token = Token.new(Token::Multiply)
		elsif Lexer::DevidePattern.match(@analized_string)
			token = Token.new(Token::Devide)
		elsif Lexer::RightParenPattern.match(@analized_string)
			token = Token.new(Token::RightParen)
		elsif Lexer::LeftParenPattern.match(@analized_string)
			token = Token.new(Token::LeftParen)
		elsif Lexer::PowerPattern.match(@analized_string)
			token = Token.new(Token::Power)
		elsif Lexer::ModuloPattern.match(@analized_string)
			token = Token.new(Token::Modulo)
		elsif Lexer::NumberPattern.match(@analized_string)
			token = Token.new(Token::Number)
			token.value = $&.to_f
		elsif Lexer::FunctionPattern.match(@analized_string)
			token = Token.new(Token::Function)
			token.name = $&
		elsif Lexer::EndPattern.match(@analized_string)
			token = Token.new(Token::End)
			#@analized_string = $'
		else
			raise "Parse Error"
		end
		@analized_string = $'
		return @previous_token = token
	end
	
	def revert
		@return_previous_token = true
	end
end

class Parser
	AdditiveOperator = [Token::Plus, Token::Minus]
	MultiplitiveOperator = [Token::Multiply, Token::Devide]
	ModuloOperator = [Token::Modulo, Token::Power]
	def initialize(input)
		@lexer = Lexer.new(input)
	end
	
	def parse
		ret = operator_add()
		ret
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
		elsif ret.kind == Token::Function
			ret = operator_add()
			raise "Parse Error" if @lexer.next_token().kind != Token::RightParen
			return ret
		else
			raise "Parse b   Error"
		end
	end
end

puts Parser.new("100 % 7 * (100 + 2) ").parse
