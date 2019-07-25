require 'json'
require 'open-uri'

module Scans_Get
  class Generator < Jekyll::Generator
    safe true
    priority :highest

    def generate(site)
      domains = site.config['domainlist']
      if !domains
        return
      end
      if !domains.kind_of?(Array)
        domains = [domains]
      end
      domains.each do |d|
        begin
          url = site.config['scanner_url'] + 'api/v1/domains/' + d + '/'
          site.data[d] = JSON.load(open(url))

          data_source = (site.config['data_source'] || '_data')
          unless File.directory?(data_source)
            Dir.mkdir(data_source)
          end
          path = "#{data_source}/#{d}.json"
          open(path, 'wb') do |file|
            file << JSON.generate(site.data[d])
          end
        rescue StandardError => e  
          puts e.message  
          puts e.backtrace.inspect
          next
        end
      end
    end
  end
end
