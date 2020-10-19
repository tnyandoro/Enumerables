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
end

# p (0...7).my_each
# p [2,5,6,6].my_each
# hs = {"ruby" => "programming", "OOP" => "develop"}
