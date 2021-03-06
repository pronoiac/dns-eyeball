#!/usr/bin/env ruby 

require "Resolv"
require "byebug"
require "net/http"

HTTP_TIMEOUT = 5 # sec. 


def print_dns_record(ress)
  ress.each do |record| 
    case record
    when Resolv::DNS::Resource::IN::CNAME
      print "CNAME, points to: "
      p record.name
      puts "[ prettier: #{ress.first.name.to_s}#{ '.' if ress.first.name.absolute? } ]"
      puts "(ttl: #{record.ttl})"
      return
    when Resolv::DNS::Resource::IN::A
      print "A, points to: "
      print record.address
      puts " (ttl: #{record.ttl})"
      return
    else
      # not recognized
    end
  end # /loop over records
  puts "No DNS record parsed."
end # /print_status

def show_http_header(host)
  print "fetching HTTP headers: "

  begin
    http = Net::HTTP.start(
      host,
      open_timeout: HTTP_TIMEOUT,
      read_timeout: HTTP_TIMEOUT)
    resp = http.head('/')
  rescue
    puts "no response! (#{HTTP_TIMEOUT} sec timeout)"
    return false
  end
  
  case resp.code.to_i
  when 200
    puts "200 OK"
  when 301
    puts "301 Permanent redirect: #{resp['location']}"
  when 302
    puts "302 Temp redirect: #{resp['location']}"
  else
    puts resp.code
  end
  http.finish
end


# die unless ARGV.length == 2
begin
  Resolv.getaddress "www.google.com"
rescue
  puts "couldn't look up google.com. exiting!"
  exit!
end

domain = ARGV[0] || "pronoiac.org"

Resolv::DNS.open do |dns|
  [domain, "www." + domain].each do |host|

    puts
    puts "== querying #{host}..."
    ress = dns.getresources host, Resolv::DNS::Resource::IN::ANY
    
    if ress.count == 0
      puts "No records returned!"
    else
      print_dns_record(ress)
      show_http_header(host)
    end
  end # /host
end # /main

