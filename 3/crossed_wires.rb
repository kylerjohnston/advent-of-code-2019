#!/usr/bin/env ruby
# Part 1 answer is 1431
# Part 2 answer is 48012

require_relative 'grid_sorted'

lines = File.open('input.txt').readlines
grid = Grid.new
grid.add_route(lines[0].strip)
grid.add_route(lines[1].strip)
