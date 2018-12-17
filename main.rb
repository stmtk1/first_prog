require "./parser"


p = Parser.new()
p.parse("a = 100 % 7 * (100 + 2)")
p.parse("a + 1")
