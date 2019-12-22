#!/usr/bin/env ruby

require "minitest/autorun"
require_relative "../cb"

class TestUniverse < Minitest::Test
  def setup
    @u1 = Universe.new
    maps = File.open("map_data.txt").readlines.map{ |x| x.chomp }
    maps.each do |map|
      OrbitMap.new(map, @u1)
    end

    @u2 = Universe.new
    maps = File.open("p2-test-input.txt").readlines.map{ |x| x.chomp }
    maps.each do |map|
      OrbitMap.new(map, @u2)
    end
    @u2.count_orbits
  end

  def test_orbit_count?
    assert_equal(42, @u1.count_orbits)
  end

  def test_transfer_count?
    assert_equal(4, @u2.count_transfers(@u2.celestial_bodies['YOU'], @u2.celestial_bodies['SAN']))
  end
end
