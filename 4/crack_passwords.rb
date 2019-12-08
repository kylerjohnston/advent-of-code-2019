#!/usr/bin/env ruby
# Part 1: 481

require_relative 'cracker'

c = Cracker.new(372037, 905157, 6)
puts "Total passwords (part 1): #{c.passwords.length.to_s}"
puts "Better passwords (part 2): #{c.better_passwords.length.to_s}"
