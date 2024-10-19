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

    # Hent en tilfældig proxy uden at validere
    def get_random_proxy
      @proxies.sample
    end

    # Metode til at udføre en HTTP-get-anmodning med eller uden proxy
    def fetch_with_proxy(uri_str)
      uri = URI.parse(uri_str)
      proxy = get_random_proxy

      begin
        http = Net::HTTP.new(uri.host, uri.port, proxy.addr, proxy.port)
        http.use_ssl = (uri.scheme == 'https')
        http.open_timeout = @timeout
        http.read_timeout = @timeout
        request = Net::HTTP::Get.new(uri.request_uri)
        response = http.request(request)
        return response.body
      rescue
        # Hvis der opstår en fejl med proxyen, prøv uden proxy
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = (uri.scheme == 'https')
        http.open_timeout = @timeout
        http.read_timeout = @timeout
        request = Net::HTTP::Get.new(uri.request_uri)
        response = http.request(request)
        return response.body
      end
    end
  end
end
