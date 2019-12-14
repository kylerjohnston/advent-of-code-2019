#!/usr/bin/env ruby
# Day 2, Part 1 returns 5434663
# Day 2, Part 2 returns 4559

class IntcodeComputer
  attr_reader :result

  def initialize(*intcode)
    @intcode = intcode
    @result = calculate_intcode(@intcode.dup, 0)
    @answer = find_answer(0, 0, 0)
  end

  def calculate_intcode(data, pointer)
    a = data[pointer + 1]
    b = data[pointer + 2]
    c = data[pointer + 3]
    case data[pointer]
    when 99
      return data
    when 1
      data[c] = data[a] + data[b]
    when 2
      data[c] = data[a] * data[b]
    end
    return calculate_intcode(data, pointer + 4)
  end

  # Day 2, Question 2
  def day_2_q_2
    puts find_answer(0, 0, 0)
  end

  private
  # Day 2, Question 2
  def find_answer(noun, verb, state)
    data = @intcode.dup
    data[1] = noun
    data[2] = verb
    data = calculate_intcode(data, 0)
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
