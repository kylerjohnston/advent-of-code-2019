class Cracker
  attr_reader :passwords

  def initialize(range_min, range_max, length)
    @range_min = range_min
    @range_max = range_max
    @length = length
    @passwords = find_passwords
  end

  private

  def find_passwords
    all_combinations = *(@range_min..@range_max)
    matches = []
    all_combinations.each do |x|
      password = Password.new(x, @length)
      if password.is_match?
        matches << password
      end
    end
    return matches
  end
end

class Password
  def initialize(password, length)
    @password = password.to_s
    @pass_array = @password.split('')
    @length = length
  end

  def is_match?
    if self.is_right_length? and self.has_dupes? and self.is_increasing?
      return true
    end
    return nil
  end

  # Condition 1
  def is_right_length?
    if @password.length > @length
      return nil
    end
    while @password.length < @length
      @password.prepend('0')
    end
    return true
  end

  # Condition 2 satisfied in Cracker.find_passwords
  # Condition 3
  def has_dupes?
    for i in 0..@pass_array.length - 2
      if @pass_array[i] == @pass_array[i + 1]
        return true
      end
    end
    return nil
  end

  # Condition 4
  def is_increasing?
    for i in 1..@pass_array.length - 1
      if @pass_array[i] < @pass_array[i - 1]
        return nil
      end
    end
    return true
  end
end
