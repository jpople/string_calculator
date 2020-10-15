# TODO:
# move to equation-as-object approach (done?)
# add ability to handle:
#     exponentiation
#     non-ints
#     inputs of arbitrary length (done)
#         order of operations (done)
#             parentheses (done)
#     invalid expressions (e.g. "2 -", "2 3 *", "$$$$$", "hello") (done)
#         valid inputs but without appropriate spacing built in; what do?
#             how do we even check for this?

class Equation
    attr_accessor :values
    attr_accessor :ops
    attr_accessor :usable

    def initialize eq_string
        self.usable = true
        self.values = []
        self.ops = []
        eq_array = eq_string.split()
        # sort alternating characters into values and ops arrays
        # ideally, this puts all the numbers in order into values and all the operators in order in ops
        eq_array.each_with_index do |item, index| 
            if index % 2 == 0
                values << item.to_i # why do we not need self. here again?
            else
                ops << item.to_sym # see above
            end
        end
        # make sure our result is actually something we can use
        values.each do |value|
            if !value.is_a? Integer
                usable = false
            end
        end
        ops.each do |op|
            if ![:+, :-, :*, :/, :%].include? op
                self.usable = false # why do we need self. here again?
            end
        end
    end
end

class Calculator
    def evaluate equation
        # only run evaluate loop if it won't break
        if !equation.usable
            return false
        # main evaluate loop; applies first operation in ops to first two values in values until ops is empty
        elsif equation.ops.length == 0
            return equation.values[0]
        else
            while equation.ops.length > 0
                equation.values[0] = equation.values[0].public_send(equation.ops[0], equation.values[1])
                equation.ops.delete_at 0
            end
        return equation.values[0]
        end
    end
end