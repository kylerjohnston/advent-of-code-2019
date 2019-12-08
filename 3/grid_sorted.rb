class Grid
  attr_reader :routes, :intersections

  def initialize
    @routes = []
    @intersections = {'mh_distance' => {}, 'fewest_steps' => {}}
  end

  def add_route(step_string)
    steps = step_string.split(',')
    route = calculate_route([0, 0], steps.reverse, [], 0)
    @routes << route.sort_by{ |x| x['distance'] }
    if @routes.length > 1
      print "Calculating closest intersection by Manhattan distance... "
      @intersections['mh_distance'] = find_mh_distance
      puts @intersections['mh_distance']
      print "Calculating closest intersection by fewest total steps... "
      @intersections['fewest_steps'] = find_fewest_steps
      puts @intersections['fewest_steps']
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

  def find_fewest_steps
    intersection = nil
    @routes[0].sort_by{ |x| [x['count'], x['distance']] }.each do |x|
      @routes[1].sort_by{ |x| [x['count'], x['distance']] }.each do |y|
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

  def find_mh_distance
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
