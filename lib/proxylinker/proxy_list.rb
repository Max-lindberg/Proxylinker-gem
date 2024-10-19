require 'net/http'
require 'uri'
require 'ostruct'

module Proxylinker
  class ProxyList
    attr_reader :proxies, :timeout

    # Initialiserer ProxyList med en filsti og timeout-parameter (standard: 5 sek.)
    def initialize(proxy_file_path, timeout: 5)
      @proxy_file_path = proxy_file_path
      @timeout = timeout
      @proxies = load_proxies
    end

    # Læs proxies fra en fil (forventet format: IP:PORT per linje)
    def load_proxies
      proxies = []
      File.readlines(@proxy_file_path).each do |line|
        addr, port = line.strip.split(':')
        proxies << OpenStruct.new(addr: addr, port: port)
      end
      proxies
    end

    # Validér en proxy ved at forsøge at oprette forbindelse til en kendt URL
    def validate_proxy(proxy)
      uri = URI.parse('https://google.com')
      http = Net::HTTP.new(uri.host, uri.port, proxy.addr, proxy.port)
      http.open_timeout = @timeout
      http.read_timeout = @timeout

      begin
        response = http.get(uri.path)
        return response.is_a?(Net::HTTPSuccess)
      rescue
        false
      end
    end

    # Hent en tilfældig fungerende proxy
    def get_random_proxy
      @proxies.shuffle.each do |proxy|
        return proxy if validate_proxy(proxy)
      end
      nil
    end
  end
end
