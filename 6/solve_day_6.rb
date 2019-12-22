#!/usr/bin/env ruby
# Day 6, Part 1 solution: 162439

require_relative 'cb'

maps = File.open("input.txt").readlines.map{ |x| x.chomp }

u = Universe.new

maps.each do |map|
  OrbitMap.new(map, u)
end

puts u.count_orbits
