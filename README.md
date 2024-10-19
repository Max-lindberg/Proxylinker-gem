# Proxymate

## Installation
```bash
gem install proxymate
```

## Usage
Format for proxy_list.txt:
```
127.0.0.1:8080
127.0.0.1:8081
```

```ruby
require 'proxylinker'

proxy_list = Proxylinker::ProxyList.new('path/to/proxy_list.txt')

proxy = proxy_list.get_random_proxy

if proxy
  puts "Bruger proxy: #{proxy.addr}:#{proxy.port}"
else
  puts "Ingen fungerende proxy fundet."
end
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct
