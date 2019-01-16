# devbin

Working in multiple containerized environment seamlessly. Within the application folder, type one command, give the name of other application, then it should work.

## Motivation
When working in a multiple containerized environment, it gets boring to repeatedly make `cd` back and forth between application's folders to execute some commands.
The Convention-Over-Configuration pattern is quite popular this day, we all name our containers, arrange folders base on some predictable rules, then make some command alias for faster integrate with other containers. **devbin** will help us to bootstrapping + managing our environment seamlessly. The idea is: just remember the application name + the command you want to execute, **devbin** do all other boring things.

## Installation

Install gem as as:

    $ gem install devbin

## Usage
TL; DR;

    $ devbin help


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yeuem1vannam/devbin. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the Devbin project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/devbin/blob/master/CODE_OF_CONDUCT.md).

## Copyright

Copyright (c) 2019 Phuong 'J' Le H. See [MIT License](LICENSE.txt) for further details.