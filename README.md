# FsTimestamper

A Ruby library for changing filesystem timestamps. Provides a simple and unified interface for changing filesystem timestamps using different timestamp assignation methods and supporting mac, windows and linux filesystems.

## Description

This rubygem is written to provide system administrators a handy tool to change filesystem timestamps using different methods and without dealing with filesystem types differences. 

The final version of this gem will include the following features:
- Only change user specified timestamps
- Change only filesystem timestamps that matches a specified pattern
- Allow non-recursive timestamp changes
- Allow only time or only hours timestamp changes
- Change filesystem entries timestamps using 4 different methods: fixed, original distance, sequential distance and random

## New Features

- v0.1.2: It can assign and record assigned modified and last accessed timestamps in a linux filesystem using a fixed timestamp assignation method. 

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/creyes-dev/fs_timestamper.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
