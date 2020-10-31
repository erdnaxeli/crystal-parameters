# crystal-parameters

Parse parameters from a string and output a array of strings that is usable with
`OptionParser#parse`.

It is usefull on interactive app accepting complex commands, like text bots.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     crystal-parameters:
       github: erdnaxeli/crystal-parameters
   ```

2. Run `shards install`

## Usage

```crystal
require "option_parser"
require "parameters"


parameters = Parameters.parse("ls -lh --author --hide '* *' /tmp")
# => ["ls", "-lh", "--author", "--hide", "* *", "/tmp"]

if parameters
  OptionParser.parse(parameters) do |parser|
    parser.on("ls", "list files") { }
  end
end
```

## Development

Make sure to run `make test` and `make lint` :)

## Contributing

1. Fork it (<https://github.com/erdnaxeli/crystal-parameters/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [erdnaxeli](https://github.com/erdnaxeli) - creator and maintainer
