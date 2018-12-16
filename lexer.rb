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


