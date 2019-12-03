#!/usr/bin/env ruby
# Part 1 returns 5434663
# Part 2 returns 4559

class IntcodeComputer
  attr_reader :intcode, :noun, :verb, :answer
  def initialize(*data)
    @data = data
    @intcode = calculate_intcode(@data.dup, 0)
    @answer = find_answer(0, 0, 0)
  end

  def calculate_intcode(data, pointer)
    a = data[pointer + 1]
    b = data[pointer + 2]
    c = data[pointer + 3]
    if data[pointer] == 99
      return data
    elsif data[pointer] == 1
      data[c] = data[a] + data[b]
    elsif @data[pointer] == 2
      data[c] = data[a] * data[b]
    end
    return calculate_intcode(data, pointer + 4)
  end

  def find_answer(noun, verb, state)
    data = @data.dup
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
