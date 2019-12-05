#!/usr/bin/env ruby
# Part 1 answer is 1431

class Grid
  attr_reader :routes, :intersection, :distance

  def initialize
    @routes = []
    @intersections = []
  end

  def add_route(step_string)
    steps = step_string.split(',')
    route = calculate_route([0, 0], steps.reverse, [])
    @routes << route.sort_by{ |x| x['distance'] }
    if @routes.length > 1
      @intersection = find_intersections
    end
  end

  private
  def calculate_route(start, steps, route)
    x = start[0]
    y = start[1]

    if steps.length == 0
      return route
    else
      step = steps.pop
      next_step = step[1..].to_i
      direction = step[0]
      case direction
      when "U"
        stop_point = y + next_step
        while y < stop_point
          y += 1
          route << {'x' => x, 'y' => y, 'distance' => x.abs + y.abs}
        end
      when "D"
        stop_point = y - next_step
        while y > stop_point
          y -= 1
          route << {'x' => x, 'y' => y, 'distance' => x.abs + y.abs}
        end
      when "R"
        stop_point = x + next_step
        while x < stop_point
          x += 1
          route << {'x' => x, 'y' => y, 'distance' => x.abs + y.abs}
        end
      when "L"
        stop_point = x - next_step
        while x > stop_point
          x -= 1
          route << {'x' => x, 'y' => y, 'distance' => x.abs + y.abs}
        end
      end
      calculate_route([x, y], steps, route)
    end
  end

  def find_intersections
    @routes[0].each do |x|
      @routes[1].each do |y|
        if x['distance'] < y['distance']
          break
        end
        if x['x'] == y['x'] and x['y'] == y['y']
          return x
        end
      end
    end
  end
end
