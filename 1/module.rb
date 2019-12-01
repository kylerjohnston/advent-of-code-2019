#!/usr/bin/env ruby

class Module
  TOTAL_FUEL = []
  attr_reader :weight, :fuel_required, :fuel
  def initialize(weight)
    @weight = weight.to_i
    @fuel = Fuel.new((@weight / 3) - 2)
    @fuel_required = calculate_fuel(@fuel, 0)
    TOTAL_FUEL << @fuel_required
  end
  def calculate_fuel(fuel, state)
    if fuel.fuel_required == 0
      return fuel.mass + state
    else
      return calculate_fuel(fuel.fuel_required, state + fuel.mass)
    end
  end
end

def Module.fuel_required
  return Module::TOTAL_FUEL.inject(0, :+)
end

class Fuel
  TOTAL_FUEL = []
  attr_reader :mass, :fuel_required
  def initialize(mass)
    if mass.to_i > 0
      @mass = mass.to_i
      @fuel_required = Fuel.new((@mass / 3) - 2)
    else
      @mass = 0
      @fuel_required = 0
    end
    TOTAL_FUEL << @mass
  end
end

def Fuel.total_fuel
  return Fuel::TOTAL_FUEL.inject(0, :+)
end

all_modules = []

file = File.open('input.txt')
puts "Reading input file..."
lines = file.readlines
lines.each { |x|
  all_modules << Module.new(x.to_i)
}

print "All modules would require ", Fuel.total_fuel, " fuel.\n"
