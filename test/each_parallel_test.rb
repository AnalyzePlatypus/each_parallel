require "test_helper"

class EachParallelTest < Minitest::Test
  using EachParallel

  def test_that_it_has_a_version_number
    refute_nil ::EachParallel::VERSION
  end

  describe "EachParallel extension for Array" do
    describe ":each_parallel" do
      it "should add a `each_parallel` method to Array" do
        [].each_parallel {}
      end
  
      it "should call `block` array.size times" do
        array = [1,2,3,4,5]
        array_item_count = array.count
        block_called_count = 0
  
        array.each_parallel { block_called_count += 1 }
  
        assert_equal array_item_count, block_called_count
      end
  
      it "should call `block` with each item from the array" do
        array = [1,2,3,4,5]
        processed = []
        array.each_parallel(workers: 1) {|item| processed <<  item}
        assert_equal array, processed
      end
    end
    
    describe ":each_parallel performance" do
      jobs = (0..20).to_a
      start = Time.now
      jobs.each {sleep 0.005}
      single_thread_time = Time.now - start
      start = Time.now
      jobs.each_parallel(workers: 20) {sleep 0.005}
      multi_thread_time = Time.now - start
      #assert multi_thread_time < single_thread_time
    end

    describe ":to_queue" do
      it "should convert the array into a queue" do
        array = [1,2,3,4,5]
        queue = array.to_queue
        items_from_queue = []
        queue.length.times { items_from_queue << queue.pop}
        assert_equal array, items_from_queue
      end
    end
  end

end