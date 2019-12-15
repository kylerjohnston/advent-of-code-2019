class IntcodeComputer
  attr_reader :result, :intcode

  def initialize(intcode)
    @intcode = intcode
    @result = parse_intcode(@intcode.dup, 0)
  end

  def parse_intcode(data, pointer)
    op_expr = Op_Expr.new(data, data[pointer], data[pointer + 1],
                          data[pointer + 2], data[pointer + 3])
    if op_expr.actions['exit']
      return data
    elsif op_expr.actions['output']
      puts op_expr.actions['output']
    elsif op_expr.actions['update']
      data[op_expr.actions['update']['location']] = op_expr.actions['update']['value']
    end
    return parse_intcode(data, pointer + op_expr.actions['next_step'])
  end
end

class Op_Expr
  attr_reader :opcode, :params, :actions
  OPCODES = {
    '1' => {
      'action' => 'update',
      'method' => '+',
      'params' => 3
    },
    '2' => {
      'action' => 'update',
      'method' => '*',
      'params' => 3
    },
    '3' => {
      'action' => 'update',
      'method' => 'gets',
      'params' => 1
    },
    '4' => {
      'action' => 'output',
      'method' => nil,
      'params' => 1
    },
    '99' => {
      'action' => 'exit',
      'method' => nil,
      'params' => 0
    }
  }

  def initialize(intcode, op_and_pmode, *params)
    # We receive opcode and pmode together as one argument
    # E.g. 1002 is an opcode of 02 and parameter modes 0, 1, 0
    @opcode, @params = get_opcode_and_params(op_and_pmode, params)
    @intcode = intcode
    @actions = parse_expression(@opcode.dup, @params.dup)
  end

  private
  def get_opcode_and_params(op_and_pmode, raw_params)
    if op_and_pmode.to_s.length < 2
      opcode = op_and_pmode
      pmodes = []
    else
      opcode = op_and_pmode.to_s[-2..].to_i
      # Reverse this because parameter modes are read right to left
      pmodes = op_and_pmode.to_s[0..-3].reverse.split('').map { |x| x.to_i }
    end

    params = []

    # Reduce parameters to the number required by the opcode
    while raw_params.size > OPCODES[opcode.to_s]['params']
      raw_params.pop
    end

    # We need to pad pmodes with 0s until we have one for each parameter
    # An empty pmode slot implies 0
    while pmodes.size < raw_params.size
      pmodes << 0
    end

    raw_params.each_with_index do |param, i|
      params << {'param' => param, 'mode' => pmodes[i]}
    end
    return opcode, params
  end

  def parse_expression(opcode, params)
    actions = {
      'update' => nil,
      'exit' => nil,
      'output' => nil,
      'next_step' => nil
    }
    case OPCODES[opcode.to_s]['action']
    when 'exit'
      actions['exit'] = 1
      return actions
    when 'output'
      actions['output'] = get_output(params)
    when 'update'
      actions['update'] = {
        'value' => get_update_value(params, OPCODES[opcode.to_s]['method']),
        'location' => params.pop['param'] # Never pmode 1
      }
    end
    actions['next_step'] = @params.size + 1
    return actions
  end

  def get_output(params)
    case params[0]['mode']
    when 0
      return @intcode[params[0]['param']]
    when 1
      return params[0]['param']
    end
  end

  def get_update_value(params, method)
    if method == 'gets'
      print "Input: "
      return gets.chomp.to_i
    end

    factors = []
    params[0..-2].each do |p|
      case p['mode']
      when 0
        factors << @intcode[p['param']]
      when 1
        factors << p['param']
      end
    end

    case method
    when '*'
      return factors.reduce(1, :*)
    when '+'
      return factors.reduce(0, :+)
    end
  end
end
