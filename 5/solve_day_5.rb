#!/usr/bin/env ruby
# Day 5, Part 1 answer: 13346482

require_relative 'intcode'

intcode_raw = File.open('input.txt').read
intcode = intcode_raw.split(',').map { |x| x.to_i }

c = IntcodeComputer.new(intcode)
