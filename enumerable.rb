module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    arr = to_a
    while i < arr.length
      yield(arr[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < to_a.length
      yield to_a([i], i)
      i += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    new_arr = []
    to_a.my_each { |item| new_arr << item if yield(item) }
    new_arr
  end

  def my_all?(argument = nil)
    return to_enum(:my_all?) unless block_given?

    status = true

    if !argument.nil?
      if argument.is_a? Class
        to_a.my_each do |i|
          status = i.class.ancestors.include? argument
          break unless status
        end
      else
        to_a.my_each do |i|
          status = (argument === i)
          break unless status
        end
      end
    else
      if block_given?
        to_a.my_each do |i|
          status = yield i
          break unless status
        end
      else
        to_a.my.each do |i|
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

  def my_none?(arg = nil)
    arr = to_a
    confirm = true

    if !arg.nil?
      if arg.is_a? Class
        arr.my_each do |i|
          confirm = !(i.class.ancestors.include? arg)
          break unless confirm
        end

      else
        arr.my_each do |i|
          confirm = !(arg === i)
          break unless confirm
        end
      end
    else
      if block_given?
        arr.my_each do |i|
          confirm = !(yield i)
          break unless confirm
        end
      else
        arr.my_each do |i|
          confirm = (i == false || i.nil?)
          break unless confirm
        end
      end
    end
    confirm
  end

  def my_count(argument = nil)
    count = 0
    arr = to_a
    if block_given?
      arr.length.times do |i|
        count += 1 if yield(arr[i])
      end
      count
    elsif !argument.nil?
      my_each do |item|
        count += 1 if item == argument
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
    accumul = to_a[0]
    rest = to_a[1..-1]
    code = proc { |el| accumul = yield(accumul, el) }
    raise LocalJumpError if !block_given? && arg1.nil? && arg2.nil?

    if block_given?
      unless arg1
        rest.my_each(&code)
        return accumul
      end
      accumul = arg1
      to_a.my_each(&code)
      return accumul
    end

    if arg1 && arg2
      accumul = arg1
      my_each { |el| accumul = accumul.send(arg2, el) }
      return accumul
    end
    rest.my_each { |el| accumul = accumul.send(arg1, el) } if arg1.is_a?(Symbol)
    accumul
  end
end

def multiply_els(arr)
  arr.my_inject(:*)
end

p (0...7).my_each
n = [2, 2, 6, 6]
hs = {"ruby" => "programming", "OOP" => "develop"}
puts n.all?(&:even?)
puts n.my_all?(&:even?)
puts n.my_any?(&:even?)
puts n.my_none?(&:even?)
puts n.my_count(&:even?)
puts n.my_map(&:even?)

p (5..10).my_inject { |sum, n| sum + n }
p (5..10).my_inject { |product, n| product * n }
p (5..10).my_inject(:+)
puts multiply_els(n)

p [1, 2, 3, 4].my_inject
p [1, 2, 3].my_each(&proc { |x| x > 2 }) == [1, 2, 3]
p [1, 2, 3].my_each_with_index.class == Enumerator
p [1, 2, 3, 4].my_select.class == Enumerator
p [true, [false]].all? == [true, [false]].my_all?
 my_proc = Proc.new { |n| (n % 7).zero? }

p [1,2,3].count(&proc{|num|num%2==0}) == [1,2,3].my_count(&proc{|num|num%2==0})
p [1, 2, 3, 4, 5].my_none?(&my_proc) == [1, 2, 3, 4, 5].none?(&my_proc)
p [false, nil, false].none? == [false, nil, false].my_none?
p %w[dog cat].none?(/x/) == %w[dog cat].my_none?(/x/)
p ['dog','car'].none?(5) == ['dog','car'].my_none?(5)
p [1, 2, 3].count(&my_proc)
p [1, 2, 3].my_none?(1)
