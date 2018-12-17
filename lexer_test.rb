require "./lexer"
class LexerTest
    def parse(input)
        lexer = Lexer.new(input)
        while (token = lexer.next_token).kind != Token::EndLine
            puts token.kind
        end
    end
end


p = LexerTest.new()
#p.parse("a = 100 % 7 * (100 + 2)")
#p.parse("a + 1")
#p.parse("if 1 < 2")
#p.parse("if 2 > 1")
p.parse("if 1 == 1")
