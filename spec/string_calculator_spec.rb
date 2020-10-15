require "string_calculator"

describe Equation do
    let(:short_test) {Equation.new("1")}
    context "short equation test: given 1" do
        it "puts number in values" do
            expect(short_test.values).to eql([1])
        end
        it "makes operations empty" do
            expect(short_test.ops).to eql([])
        end
    end
    let(:long_test) {Equation.new("1 + 1 + 1")}
    context "long equations test: given 1 + 1 + 1" do
        it "puts numbers in order in values" do
            expect(long_test.values).to eql([1, 1, 1])
        end
        it "puts operations in order in ops" do
            expect(long_test.ops).to eql([:+, :+])
        end
    end
    let(:paren_test) {Equation.new("( 1 + 1 ) * 2")}
    context "parentheses test: given (1 + 1) * 2" do
        it "puts numbers in order in values" do
            expect(paren_test.values).to eql([1, 1, 2])
        end
        it "puts operations in order in ops" do
            expect(paren_test.ops).to eql([:+, :*])
        end
    end
    let(:ooo_test) {Equation.new("1 + 2 * 3")}
    context "order of operations test: given 1 + 2 * 3" do
        it "puts numbers in order in values" do
            expect(ooo_test.values).to eql([2, 3, 1])
        end
        it "puts operations in order in ops" do
            expect(ooo_test.ops).to eql([:*, :+])
        end
    end
    let(:read_test) {Equation.new("2 2 +")}
    context "readability test: given 2 2 +" do
        it "sets usable to false" do
            expect(read_test.usable).to be false
        end
    end
end

describe Calculator do
    let(:dr_buttons) {Calculator.new}
    describe "input handling" do
        context "if given a single number" do
            it "returns that number" do
                test_eq = Equation.new("3")
                expect(dr_buttons.evaluate(test_eq)).to eql(3)
            end
        end
        context "if given unusable input" do
            it "returns false" do
                test_eq = Equation.new("2 2 +")
                expect(dr_buttons.evaluate(test_eq)).to eql(false)
            end
        end
    end
    describe "arithmetic" do
        context "if given two numbers with a +" do
            it "adds them" do
                test_eq = Equation.new("2 + 2")
                expect(dr_buttons.evaluate(test_eq)).to eql(4)
            end
        end
        context "if given two numbers with a -" do
            it "subtracts the second from the first" do
                test_eq = Equation.new("5 - 3")
                expect(dr_buttons.evaluate(test_eq)).to eql(2)
            end
        end
        context "if given two numbers with a *" do
            it "multiplies them" do
                test_eq = Equation.new("2 * 3")
                expect(dr_buttons.evaluate(test_eq)).to eql(6)
            end
        end
        context "if given two numbers with a /" do
            it "divides the first by the second" do
                test_eq = Equation.new("10 / 2")
                expect(dr_buttons.evaluate(test_eq)).to eql(5)
            end
        end
        context "if given two numbers with a %" do
            it "takes the first mod the second" do
                test_eq = Equation.new("9 % 4")
                expect(dr_buttons.evaluate(test_eq)).to eql(1)
            end
        end
    end
end