#!/usr/bin/env ruby 

require "Resolv"
require "byebug"


def print_record(ress)
  ress.each do |record| 
    case ress.first
    when Resolv::DNS::Resource::IN::CNAME
      puts "CNAME, points to..."
      p ress.first.name
      puts "[ prettier: #{ress.first.name.to_s}#{ '.' if ress.first.name.absolute? } ]"
      return
    when Resolv::DNS::Resource::IN::A
      puts "A, points to..."
      puts ress.first.address
      return
    end
  end # /loop over records
end # /print_status


# die unless ARGV.length == 2
begin
  Resolv.getaddress "www.google.com"
rescue
  puts "couldn't look up google.com. exiting!"
  exit!
end
# byebug

domain = ARGV[0] || "pronoiac.org"

Resolv::DNS.open do |dns|
  [domain, "www." + domain].each do |host|

    puts
    puts "== querying #{host}... =="
    ress = dns.getresources host, Resolv::DNS::Resource::IN::ANY
    
    if ress.count == 0
      puts "No records returned!"
    else
      print_record(ress)
    end
  end # /host
end # /main

