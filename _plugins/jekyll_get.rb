require 'json'
require 'open-uri'
require 'uri/http'

module Scans_Get
  class Generator < Jekyll::Generator
    safe true
    priority :highest

    def generate(site)
      data_source = (site.config['data_source'] || '_data')
      unless File.directory?(data_source)
        Dir.mkdir(data_source)
      end

      # slurp down code.json data
      url = site.config['scanner_url'] + 'search200/json/?200page=/code.json&present=Present'
      data = JSON.load(open(url))
      site.data['codejsondata'] = []
      data.each do |d|
        domain = d['domain']
        agency = d['agency']
        final_url = d['pagedata']['/code.json']['final_url']
        final_uri = URI(final_url)
        content_type = d['pagedata']['/code.json']['content_type']
        # allowedmimetypes = ['application/json', 'application/octet-stream', 'text/plain','text/plain; charset=UTF-8', 'text/html; charset=utf-8']
        allowedmimetypes = ['application/json', 'application/octet-stream']
  
        if final_uri.host.include? domain
          if allowedmimetypes.include? content_type
            codejsondata = {}
            codejsondata['domain'] = domain
            codejsondata['agency'] = agency
            codejsondata['final_url'] = final_url
            site.data['codejsondata'] << (codejsondata)
          end
        end
      end
      path = "#{data_source}/codejsondata.json"
      open(path, 'wb') do |file|
        file << JSON.generate(site.data['codejsondata'])
      end

      # slurp down data.json data
      url = site.config['scanner_url'] + 'search200/json/?200page=/data.json&present=Present'
      data = JSON.load(open(url))
      site.data['datajsondata'] = []
      data.each do |d|
        domain = d['domain']
        agency = d['agency']
        final_url = d['pagedata']['/data.json']['final_url']
        final_uri = URI(final_url)
        content_type = d['pagedata']['/data.json']['content_type']
        # allowedmimetypes = ['application/json', 'application/octet-stream', 'text/plain','text/plain; charset=UTF-8', 'text/html; charset=utf-8']
        allowedmimetypes = ['application/json', 'application/octet-stream']
  
        if final_uri.host.include? domain
          if allowedmimetypes.include? content_type
            datajsondata = {}
            datajsondata['domain'] = domain
            datajsondata['agency'] = agency
            datajsondata['final_url'] = final_url
            site.data['datajsondata'] << (datajsondata)
          end
        end
      end
      path = "#{data_source}/datajsondata.json"
      open(path, 'wb') do |file|
        file << JSON.generate(site.data['datajsondata'])
      end

      # slurp down the data for the main domain list page
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
