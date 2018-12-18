require "./parser"


p = Parser.new()
p p.parse("a = 100 % 7 * (100 + 2)")
p p.parse("a + 1")
p p.parse("if 1 > 2 then 1 else 12")
p p.parse("if 2 < 1 then 1 else 2")
p p.parse("if 1 == 1 then 1 else 2")
p p.parse("sqrt(2)")
p p.parse("defun a(b)")
