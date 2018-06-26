
=begin
  EachParallel Module

  Adds parallel iteration to Array using thread pooling.

  using EachParallel

  [1,2,3].each_parallel { |item|
    # do stuff 
  }

  The provided block will be executed in parallel on a default of 5 threads.
  Set the worker count with the `workers` argument:

  [1,2,3].each_parallel(workers: 2) { |item|
    # do stuff 
  }

  
=end

require "each_parallel/version"
require 'thread/pool'

module EachParallel
  refine Array do 

    def each_parallel workers: 5, &block
      pool = Thread.pool(workers)
      queue = self.to_queue
      until queue.empty?
        pool.process {
          block.call(queue.pop)
        }
      end
    end

    def to_queue arr=self
      q = Queue.new
      self.each {|item| q << item }
      q
    end

    alias to_q to_queue
  end
end