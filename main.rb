require "./lib/string_calculator.rb"

calc = Calculator.new
puts "Welcome to the string calculator, for all of your string calculation needs."
puts "For this to work correctly (or, you know, as correctly as it's going to, anyway), please make sure you enter only numbers and operators (+, -, *, /, %) separated by spaces. For example, \"4 + 8 * 12\" is a valid input."
puts "Enter an expression to solve:"
input_eq = Equation.new(gets.chomp)
puts "Your result is:"
puts calc.evaluate(input_eq)