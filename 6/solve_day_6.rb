#!/usr/bin/env ruby
# Day 6, Part 1 solution: 162439
# Day 6, Part 2 solution: 367

require_relative 'cb'

maps = File.open("input.txt").readlines.map{ |x| x.chomp }

u = Universe.new

maps.each do |map|
  OrbitMap.new(map, u)
end

puts "Part 1: #{u.count_orbits}"

transfers = u.count_transfers(u.celestial_bodies['YOU'], u.celestial_bodies['SAN'])

puts "Part 2: #{transfers.to_s}"
