module Enumerable
  def my_each
    return to_enum (:my_each) unless block_given?

    i = 0
    arr = to_a
    while i < arr.length
      yield(arr[i])
      i += 1
    end
    arr
  end

  def my_each_with_index
    return to_enum (my_each_with_index) unless block_given?

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
    to_a.my_each {|item| new_arr << item if yield(item)}
    new_arr
  end

  def my_all?(arg = nil)
    if block_given?
      to_a.my_each { |i| return false if yield(i) == false}
  end
end

# p (0...7).my_each
# p [2,5,6,6].my_each
# hs = {"ruby" => "programming", "OOP" => "develop"}
