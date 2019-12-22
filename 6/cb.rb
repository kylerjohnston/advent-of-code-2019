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
      @orbit_count += count_body_orbits(cb, 0)
    end
    return @orbit_count
  end

  private
  def count_body_orbits(cb, orbits)
    if cb.orbits
      count_body_orbits(cb.orbits, orbits + 1)
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
    orbiting_body.orbits = orbited_body
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
  attr_accessor :orbits
  attr_reader :name
  def initialize(name)
    @name = name
    @orbits = nil
  end
end
