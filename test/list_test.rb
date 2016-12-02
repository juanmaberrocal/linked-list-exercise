require 'minitest/autorun'

require './lib/list'
require './lib/node'

describe List do

  let(:list) { List.new }

  describe "#add" do
    describe "with regular list" do
      let(:list) { List.new(sorted: 0) }

      it "should add elements to end of list" do
        list.length.must_equal 0

        list.add('foo')
        list.length.must_equal 1
        list.elements.must_equal(['foo'])

        list.add('bar')
        list.length.must_equal 2
        list.elements.must_equal(['foo', 'bar'])

        list.add('baz')
        list.length.must_equal 3
        list.elements.must_equal(['foo', 'bar', 'baz'])
      end
    end

    describe "with sorted list" do
      let(:list) { List.new(sorted: 1) }

      it "should add elements based on sort order" do
        list.length.must_equal 0

        list.add('foo')
        list.length.must_equal 1
        list.elements.must_equal(['foo'])

        list.add('bar')
        list.length.must_equal 2
        list.elements.must_equal(['bar', 'foo'])

        list.add('baz')
        list.length.must_equal 3
        list.elements.must_equal(['bar', 'baz', 'foo'])
      end
    end
  end

  describe "#member?" do
    let(:data) { [1,2] }

    before do
      data.each do |i|
        list.add(i)
      end
    end

    describe "when object is member of list" do
      it "should return true" do
        list.member?(data[0]).must_equal true
      end
    end

    describe "when object is not member of list" do
      it "should return false" do
        list.member?('xxx').must_equal false
      end
    end
  end

  describe "#pop" do
    describe "with empty list" do
      it "should return nil" do
        list.length.must_equal 0
        list.pop.must_equal nil
      end
    end

    describe "with non-empty list" do
      let(:data) { [1,2] }

      before do
        data.each do |i|
          list.add(i)
        end
      end

      it "should get and remove first element from list" do
        list.elements.must_equal(data)

        list.pop.must_equal(data[0])

        list.elements.must_equal(data.slice(1, data.length))
      end

      it "should empty list of run through each" do
        list.send(:each){ |node| list.pop }

        list.length.must_equal 0
      end
    end
  end

  describe "#each" do
    let(:data) { [1,2] }

    before do
      data.each do |i|
        list.add(i)
      end
    end

    it "should loop through all elements and yield to block" do
      i=0

      list.send(:each) do |element|
        element.object.must_equal data[i]
        i += 1
      end
    end
  end

  describe "#empty?" do
    it "should return false if a head and/or tail is set" do
      list.send(:empty?).must_equal true

      list.add(1)

      list.send(:empty?).must_equal false
    end
  end

end