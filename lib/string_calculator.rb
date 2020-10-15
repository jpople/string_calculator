# TODO:
# move to equation-as-object approach (done)
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
        # add spaces around every operator character to find

        # sort alternating array entries into values and ops arrays
        # ideally, this puts all the numbers in order into values and all the operators in order in ops
        eq_array.each_with_index do |item, index| 
            if index % 2 == 0
                values << item.to_i
            else
                ops << item.to_sym
            end
        end

        # make sure our result is actually something we can use
        if !values.all? {|value| value.is_a? Integer}
            self.usable = false
        end
        if !ops.all? {|op| [:+, :-, :*, :/, :%].include? op}
            self.usable = false
        end        

        # order of operations handling
        ordered_values = []
        ordered_ops = []
        op_priorities = {:* => 1, :/ => 1, :% => 1, :+ => 0, :- => 0}

        # move first operation we have to do and its two numbers into respective ordered arrays
        while ordered_ops.length == 0 && ops.length > 0 do
            priority = op_priorities[ops.max_by {|op| op_priorities[op]}] # definitely something nicer here
            ops.each_with_index do |op, index|
                if op_priorities[op] == priority
                    ordered_ops << ops[index]
                    ordered_values << values[index]
                    ordered_values << values[index + 1]
                    ops.slice! index
                    values.slice! index, 2
                end
            end
        end

        # move remainder of ops and their corresponding values into respective ordered arrays
        while ops.length > 0 do
            priority = op_priorities[ops.max_by {|op| op_priorities[op]}] # not any better the second time
            ops.each_with_index do |op, index|
                if op_priorities[op] == priority
                    ordered_ops << ops[index]
                    ordered_values << values[index]
                    ops.slice! index
                    values.slice! index
                end
            end
        end

        if !ordered_ops.empty?
            self.values = ordered_values
            self.ops = ordered_ops
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
                equation.values[1] = equation.values[0].public_send(equation.ops[0], equation.values[1])
                equation.ops.delete_at 0
                equation.values.delete_at 0
            end
        return equation.values[0]
        end
    end
end
