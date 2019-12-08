#!/usr/bin/env ruby
# Part 1: 481

require_relative 'cracker'

c = Cracker.new(372037, 905157, 6)
puts c.passwords.length
