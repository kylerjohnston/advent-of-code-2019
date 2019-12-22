require 'set'

class Universe
  attr_reader :celestial_bodies, :orbit_count
  def initialize
    @celestial_bodies = {}
  end

  def add_body(cb)
    @celestial_bodies[cb.name] = cb
  end

  def has_body?(name)
    if @celestial_bodies.key?(name)
      return true
    else
      return nil
    end
  end

  def get_body(name)
    return @celestial_bodies[name]
  end

  def count_orbits
    @orbit_count = 0
    @celestial_bodies.each_value do |cb|
      cb.add_orbits(body_orbits(cb, []))
      @orbit_count += cb.all_orbits.size
    end
    return @orbit_count
  end
 
  def count_transfers(starting_body, ending_body, c=0)
    if starting_body.name == ending_body.name or starting_body.orbited_by.include?(ending_body.name)
      return c - 1
    elsif ending_body.all_orbits.include?(starting_body.name)
      starting_body.orbited_by.each do |body|
        if ending_body.all_orbits.include?(body)
          return count_transfers(@celestial_bodies[body], ending_body, c + 1)
        end
      end
    else
      return count_transfers(starting_body.orbits, ending_body, c + 1)
    end
  end

  private
  def body_orbits(cb, orbits)
    if cb.orbits
      orbits << cb.orbits.name
      body_orbits(cb.orbits, orbits)
    else
      return orbits
    end
  end
end

class OrbitMap
  def initialize(map, universe)
    @universe = universe
    orbited_body_name, orbiting_body_name = map.split(")")
    orbited_body = get_body(orbited_body_name)
    orbiting_body = get_body(orbiting_body_name)
    orbiting_body.set_primary_orbit(orbited_body)
    orbited_body.add_orbiter(orbiting_body.name)
  end

  private
  def get_body(name)
    if @universe.has_body?(name)
      return @universe.get_body(name)
    else
      @universe.add_body(CelestialBody.new(name))
    end
  end
end

class CelestialBody
  attr_reader :name, :orbits, :all_orbits, :orbited_by
  def initialize(name)
    @name = name
    @orbits = nil
    @all_orbits = Set[]
    @orbited_by = Set[]
  end

  def set_primary_orbit(body)
    @orbits = body
    @all_orbits.add(body.name)
  end

  def add_orbiter(name)
    @orbited_by.add(name)
  end

  def add_orbits(names)
    names.each do |name|
      @all_orbits.add(name)
    end
  end
end
