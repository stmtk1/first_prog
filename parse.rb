require "./func"
require "./token"
require "./lexer"
require "./parser"


puts Parser.new("100 % 7 * (100 + 2) ").parse
