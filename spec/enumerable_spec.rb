# enumerable.rb

require './enumerable'

describe Enumerable do
  describe '#my_each' do
    it 'returns to_enum unless block_given' do
      expect([1].my_each.class).to eql([1].each.class)
    end
    let(:test1) { [] }
    let(:test2) { [] }
    it 'returns each element of array if block is given' do
      [1, 2, 3, 5].my_each { |x| test1.push(x) }
      [1, 2, 3, 5].each { |y| test2.push(y) }
      expect(test1).to eql(test2)
    end
    h = { foo: 0, bar: 1, baz: 2 }
    let(:test3) { [] }
    let(:test4) { [] }
    it 'returns test with key' do
      h.each { |key, value| test3.push([key, value]) }
      h.my_each { |key, value| test4.push([key, value]) }
      expect(test3).to eql(test4)
    end
  end
  describe '#my_each_with_index' do
    let(:test1) { [] }
    let(:test2) { [] }
    it 'returns element and its position' do
      [1, 2, 3, 5].my_each_with_index { |x| test1.push(x) }
      [1, 2, 3, 5].each { |y| test2.push(y) }
      expect(test1).to eql(test2)
    end
    h = { foo: 0, bar: 1, baz: 2 }
    let(:test3) { [] }
    let(:test4) { [] }
    it 'returns key and value' do
      h.each_with_index { |key, value| test3.push([key, value]) }
      h.my_each_with_index { |key, value| test4.push([key, value]) }
      expect(test3).to eql(test4)
    end
    it 'returns to_enum unless block_given' do
      expect([1].my_each_with_index.class).to eql([1].each_index.class)
    end
  end
  describe '#my_select' do
    it 'returns an array containing elements that passed a particular condition in a block when called on an array' do
      expect([1, 2, 3, 4].my_select(&:even?)).to eql([1, 2, 3, 4].select(&:even?))
    end
    it 'returns an array containing elements that passed a particular condition in a block when called on a range' do
      expect((1..10).my_select(&:even?)).to eql((1..10).select(&:even?))
    end
  end
  describe '#my_all' do
    it 'returns true if given block matches specified condition' do
      # rubocop: disable Layout/LineLength
      expect(['alpha', 'apple', 'allen key'].my_all? { |x| x[0] == 'a' }).to eql(['alpha', 'apple', 'allen key'].all? { |x| x[0] == 'a' })
    end
    it 'returns false if given block does not matches specified condition' do
      expect(['bin', 'apple', 'allen key'].my_all? { |x| x[0] == 'a' }).to eql(['bin', 'apple', 'allen key'].all? { |x| x[0] == 'a' })
    end
  end
  describe '#my_any' do
    it 'returns true if any of element matches condition in given block ' do
      expect(['alpha', 'apple', 'allen key'].my_any? { |x| x[0] == 'a' }).to eql(['alpha', 'apple', 'allen key'].any? { |x| x[0] == 'a' })
    end
    it 'returns false if all of the elements does not the condition in  given block n' do
      expect(%w[bin boot bus].my_any? { |x| x[0] == 'a' }).to eql(%w[bin boot bus].any? { |x| x[0] == 'a' })
    end
  end
  describe 'my_none' do
    it 'returns false if any of the given elements match condition in the block' do
      expect(['alpha', 'apple', 'allen key'].my_none? { |x| x[0] == 'a' }).to eql(['alpha', 'apple', 'allen key'].none? { |x| x[0] == 'a' })
    end
    it 'returns true if all of the elements does not the condition in  given block n' do
      expect(%w[bin boot bus].my_none? { |x| x[0] == 'a' }).to eql(%w[bin boot bus].none? { |x| x[0] == 'a' })
    end
  end
  describe '#my_count' do
    it 'returns the number of items matching given condition if an argument is given' do
      expect([1, 2, 3, 4, 4, 7, 7, 7, 9].my_count { |i| i > 1 }).to eql([1, 2, 3, 4, 4, 7, 7, 7, 9].count { |i| i > 1 })
    end
    it 'returns length of array if block is not given' do
      expect([1, 2, 3, 4, 4, 7, 7, 7, 9].my_count).to eql([1, 2, 3, 4, 4, 7, 7, 7, 9].count)
    end
  end
  describe '#my_map' do
    it 'returns a new array if block is given' do
      expect([1, 2, 3, 4, 4, 7, 7, 7, 9].my_map { |i| i * 4 }).to eql([1, 2, 3, 4, 4, 7, 7, 7, 9].map { |i| i * 4 })
    end
    it 'returns an new array turned to a string' do
      expect([1, 2, 3].my_map(&:to_s)).to eql([1, 2, 3].map(&:to_s))
    end
  end
  describe 'my_inject' do
    it 'returns a new value for the method' do
      expect([1, 2, 3, 4, 4, 7, 7, 7, 9].my_inject(0) { |running_total, item| running_total + item }).to eql([1, 2, 3, 4, 4, 7, 7, 7, 9].inject(0) { |running_total, item| running_total + item })
    end
    it 'return an accumulated value from a given range ' do
      expect((5..10).my_inject { |sum, n| sum + n }).to eql((5..10).inject { |sum, n| sum + n })
    end
  end
  # rubocop: enable Layout/LineLength
  describe '#multiply_els' do
    it 'return multiple value value of the array' do
      expect(multiply_els([2, 4, 5])).to eql(40)
    end
  end
end
