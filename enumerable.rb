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
          status = i.class.ancestors.include? arg
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

  def my_any; end
end

# p (0...7).my_each
n = [2, 2, 6, 6]
# hs = {"ruby" => "programming", "OOP" => "develop"}
puts n.all?(&:even?)
puts n.my_all?(&:even?)
