module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    arr = to_a
    while i < arr.length
      yield(arr[i])
      i += 1
    end
    arr
  end

  def my_each_with_index
    return to_enum(my_each_with_index) unless block_given?

    i = 0
    arr = to_a
    while i < arr.length
      yield(arr[i], i)
      i += 1
    end
    self
  end

  def my_select
    return to_enum(my_select) unless block_given?

    new_arr = []
    to_a.my_each { |item| new_arr << item if yield(item) }
    new_arr
  end

  def my_all?(argument = nil)
    status = true
    arr = to_a
    if !argument.nil?
      if argument.is_a? Class
        arr.my_each do |i|
          status = i.class.ancestors.include? argument
          break unless status
        end
      else
        arr.my_each do |i|
          status = (argument === i)
          break unless status
        end
      end
    else
      if block_given?
        arr.my_each do |i|
          status = yield i
          break unless status
        end
      else
        arr.my.each do |i|
          status = !(i == false || i.nil?)
          break unless status
        end
      end
    end
    status
  end

  def my_any?(argument = nil)
    arr = to_a
    status = false
    if block_given?
      arr.length.times { |i| status = true if yield(arr[i]) }
    elsif !argument.nil?
      arr.length.times do |i|
        if argument.is_a? Regexp and arr[i].match(argument)
          status = true
        elsif argument.is_a? Class and arr[i].is_a? argument
          status = true
        elsif arr[i] == argument
          status = true
        end
      end
    else
      arr.length.times { |i| status = true if arr[i] }
    end
    status
  end

  def my_none?(argument = nil)
    arr = to_a
    status = false
    if block_given?
      arr.length.times do |i|
        status = false if yield(arr[i])
      end
    elsif !argument.nil?
      arr.length.times do |i|
        if argument.is_a? Regexp
          status = false if arr[i].match(argument)
        elsif argument.is_a? Class and arr[i].is_a? argument
          status = false
        elsif arr[i] == argument
          status = false
        end
      end
    else
      arr.length.times { |i| status = false if arr[i] }
    end
    status
  end

  def my_count(argument = nil)
    count = 0
    arr = to_a
    if block_given?
      arr.length.times do |i|
        count += i if yield(arr[i])
      end
      count
    elsif !argument.nil?
      my_each do |item|
        count += i if item == argument
      end
      count
    else
      arr.length
    end
  end

  def my_map(arg = nil)
    return to_enum(:my_map) if arg.nil? && !block_given?

    map_arr = to_a
    new_arr = []
    if !arg.nil?
      map_arr.length.times do |i|
        new_arr << arg.call(map_arr[i])
      end
    elsif block_given?
      map_arr.length.times do |i|
        new_arr << yield(map_arr[i])
      end
    else return to_enum
    end
    new_arr
  end

  def my_inject(arg1 = nil, arg2 = nil)
    if !arg1.nil? && arg2.nil? && arg1.is_a?(String) || arg1.is_a?(arg2)
      arg2 = arg1
      arg1 = nil
    end
    (raise LocalJumpError if !block_given? && arg1.nil? && arg2.nil?)
    if block_given?
      to_a.my_each { |item| arg1 = arg1.nil? ? item : yield(arg1, item) }
    elsif !arg1.nil? && arg2.nil?
      to_a.my_each { |i| arg1 yield i }
    elsif !arg2.nil?
      to_a.my_each { |i| arg1 = arg1.nil? ? i : arg1.send(arg2, i) }
    end
    arg1
  end

  def multiply_els
  end
end

# p (0...7).my_each
n = [2, 2, 6, 6]
# hs = {"ruby" => "programming", "OOP" => "develop"}
puts n.all?(&:even?)
puts n.my_all?(&:even?)
puts n.my_any?(&:even?)
puts n.my_none?(&:even?)
puts n.my_count(&:even?)
puts n.my_map(&:even?)
