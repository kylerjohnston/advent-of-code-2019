class Day2Question2 < IntcodeComputer
  attr_reader :answer

  def initialize(intcode)
    @intcode = intcode
    @answer = find_answer(0, 0, 0)
  end

  private
  # Day 2, Question 2
  def find_answer(noun, verb, state)
    data = @intcode.dup
    data[1] = noun
    data[2] = verb
    data = parse_intcode(data, 0)
    if data[0] == 19690720
      noun = noun
      verb = verb
      return 100 * noun + verb
    elsif verb < 99
      return find_answer(noun, verb + 1, state)
    else
      return find_answer(noun + 1, 0, state + 1)
    end
  end
end
