require 'test_helper'

class QuoteTest < ActiveSupport::TestCase

    test "should filter quotes by name" do
        assert_equal 2, Quote.filter_by_name("stephen").count
    end

    test "should filter quotes by name and sort them" do
        assert_equal [quotes(:three), quotes(:two)],
        Quote.filter_by_name("stephen").sort
    end

end
