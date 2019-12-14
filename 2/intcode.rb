# Day 2, Part 1 returns 5434663
# Day 2, Part 2 returns 4559

class IntcodeComputer
  attr_reader :result, :intcode

  def initialize(intcode)
    @intcode = intcode
    @result = parse_intcode(@intcode.dup, 0)
  end

  def parse_intcode(data, pointer)
    opcode = data[pointer]
    a = data[pointer + 1]
    b = data[pointer + 2]
    c = data[pointer + 3]
    case opcode
    when 99
      return data
    when 1
      data[c] = data[a] + data[b]
    when 2
      data[c] = data[a] * data[b]
    end
    return parse_intcode(data, pointer + 4)
  end
end

