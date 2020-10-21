require_relative 'enmerable.rb'

# p (0...7).my_each
# n = [2, 2, 6, 6]
# hs = {"ruby" => "programming", "OOP" => "develop"}
# puts n.all?(&:even?)
# puts n.my_all?(&:even?)
# puts n.my_any?(&:even?)
# puts n.my_none?(&:even?)
# puts n.my_count(&:even?)
# puts n.my_map(&:even?)

# p (5..10).my_inject { |sum, n| sum + n }
# p (5..10).my_inject { |product, n| product * n }
# p (5..10).my_inject(:+)
# puts multiply_els(n)

# p [1, 2, 3, 4].my_inject
# p [1, 2, 3].my_each(&proc { |x| x > 2 }) == [1, 2, 3]
# p [1, 2, 3].my_each_with_index.class == Enumerator
# p [1, 2, 3, 4].my_select.class == Enumerator
# p [true, [false]].all? == [true, [false]].my_all?
#  my_proc = Proc.new { |n| (n % 7).zero? }

# p [1,2,3].count(&proc{|num|num%2==0}) == [1,2,3].my_count(&proc{|num|num%2==0})
# p [1, 2, 3, 4, 5].my_none?(&my_proc) == [1, 2, 3, 4, 5].none?(&my_proc)
# p [false, nil, false].none? == [false, nil, false].my_none?
# p %w[dog cat].none?(/x/) == %w[dog cat].my_none?(/x/)
# p ['dog','car'].none?(5) == ['dog','car'].my_none?(5)
# p [1, 2, 3].count(&my_proc)
# p [1, 2, 3].my_none?(1)
