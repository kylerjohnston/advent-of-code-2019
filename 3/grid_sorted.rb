#!/usr/bin/env ruby
# Part 1 answer is 1431
# Part 2 answer is 48012

class Grid
  attr_reader :routes, :intersection, :distance

  def initialize
    @routes = []
  end

  def add_route(step_string)
    steps = step_string.split(',')
    route = calculate_route([0, 0], steps.reverse, [], 0)
    @routes << route.sort_by{ |x| [x['count'],x['distance']] }
    if @routes.length > 1
      @intersection = find_intersections
    end
  end

  private
  def calculate_route(start, steps, route, count)
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
          count += 1
          y += 1
          route << {'x' => x, 'y' => y, 'distance' => x.abs + y.abs, 'count' => count}
        end
      when "D"
        stop_point = y - next_step
        while y > stop_point
          count += 1
          y -= 1
          route << {'x' => x, 'y' => y, 'distance' => x.abs + y.abs, 'count' => count}
        end
      when "R"
        stop_point = x + next_step
        while x < stop_point
          count += 1
          x += 1
          route << {'x' => x, 'y' => y, 'distance' => x.abs + y.abs, 'count' => count}
        end
      when "L"
        stop_point = x - next_step
        while x > stop_point
          count += 1
          x -= 1
          route << {'x' => x, 'y' => y, 'distance' => x.abs + y.abs, 'count' => count}
        end
      end
      calculate_route([x, y], steps, route, count)
    end
  end

  def find_intersections
    intersection = nil
    @routes[0].each do |x|
      @routes[1].each do |y|
        count = x['count'] + y['count']
        if intersection != nil and count > intersection['count']
          break
        elsif x['x'] == y['x'] and x['y'] == y['y']
          if intersection.nil? or count < intersection['count']
            point = x.dup
            point['count'] = x['count'] + y['count']
            intersection = point
          end
        end
      end
    end
    return intersection
  end
end
