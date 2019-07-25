require 'json'
require 'open-uri'

module Jekyll_Get
  class Generator < Jekyll::Generator
    safe true
    priority :highest

    def generate(site)
      config = site.config['jekyll_get']
      if !config
        return
      end
      if !config.kind_of?(Array)
        config = [config]
      end
      config.each do |d|
        begin
          site.data[d['data']] = JSON.load(open(d['json']))
          if d['cache']
            data_source = (site.config['data_source'] || '_data')
            unless File.directory?(data_source)
              Dir.mkdir(data_source)
            end
            path = "#{data_source}/#{d['data']}.json"
            open(path, 'wb') do |file|
              file << JSON.generate(site.data[d['data']])
            end
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
