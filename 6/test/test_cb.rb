#!/usr/bin/env ruby

require "minitest/autorun"
require_relative "../cb"

class TestUniverse < Minitest::Test
  def setup
    @u = Universe.new
    maps = File.open("map_data.txt").readlines.map{ |x| x.chomp }
    maps.each do |map|
      OrbitMap.new(map, @u)
    end
  end

  def test_orbit_count?
    assert_equal(42, @u.count_orbits)
  end
end
