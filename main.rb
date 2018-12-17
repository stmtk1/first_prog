require "./parser"


p = Parser.new()
#p.parse("a = 100 % 7 * (100 + 2)")
#p.parse("a + 1")
p.parse("if 1 < 2")
#p.parse("if 2 > 1")
#p.parse("if 1 == 1")
