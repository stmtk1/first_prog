require "./parser"


puts Parser.new("a = 100 % 7 * (100 + 2) ").parse
