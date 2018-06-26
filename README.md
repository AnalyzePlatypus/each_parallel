# EachParallel (alpha)

Adds lightweight parallel iteration to Array using thread pooling.

```ruby
using EachParallel

[1,2,3].each_parallel do |item|
  # do stuff
end
```

The provided block will be executed in parallel on a default of 5 threads.
Set the worker count with the `workers` argument:

```ruby
[1,2,3].each_parallel(workers: 2) do |item|
  # do stuff
end
```

`EachParallel` requires a Ruby implementation that supports refinements.
* ✅ MRI
* ✅ JRuby
* ❌ Rubinius ([discussion here](https://github.com/rubinius/rubinius/issues/3715))

## Installation

Add this line to your application's Gemfile and `bundle install`:

```ruby
gem 'each_parallel'
```

Or install it globaly on your machine with:

```
$ gem install each_parallel
```



## Usage


### Before You Begin

1. `require` the gem.
2. Activate the refinement with `using EachParallel`.
3. All `Array`s will now have the `each_parallel` iterator method.

```ruby

require 'each_parallel'

[].methods.include? 'each_parallel'
# => false

using EachParallel

[].methods.include? 'each_parallel'
# => true
```

### Using `each_parallel`

```
[1,2,3,4].each_parallel do |n|
  # Do async stuff here
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Architecture

`EachParallel` patches the `Array` class using a [refinement](https://ruby-doc.org/core-2.5.1/doc/syntax/refinements_rdoc.html).
For more about refinements, see the [official docs](https://ruby-doc.org/core-2.5.1/doc/syntax/refinements_rdoc.html).


## Contributing

Bug reports and pull requests are welcome.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
