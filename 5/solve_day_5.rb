#!/usr/bin/env ruby
# Day 5, Part 1 answer: 13346482
# Day 5, Part 2 answer: 12111395

require_relative 'intcode'

intcode_raw = File.open('input.txt').read
intcode = intcode_raw.split(',').map { |x| x.to_i }

c = IntcodeComputer.new(intcode)
