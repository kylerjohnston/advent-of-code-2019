#!/usr/bin/env ruby

require_relative 'intcode'
require_relative 'day2question2'

intcode_raw = File.open('input.txt').read
intcode = intcode_raw.split(',').map { |x| x.to_i }
intcode[1] = 12
intcode[2] = 2

c = IntcodeComputer.new(intcode)

puts "Part 1: #{c.result[0]}"

p2 = Day2Question2.new(intcode)

puts "Part 2: #{p2.answer}"
