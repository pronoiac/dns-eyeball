#!/usr/bin/env ruby 

require "Resolv"
require "byebug"

# die unless ARGV.length == 2
puts "testing - google.com"
p Resolv.getaddress "www.google.com"

domain = ARGV[0] || "pronoiac.org"

Resolv::DNS.open do |dns|
  [domain, "www." + domain].each do |host|

    puts "querying #{host}..."
    ress = dns.getresources host, Resolv::DNS::Resource::IN::ANY
    p ress
    
    if ress.count == 0
      puts "No records returned!"
    else
      print_record(ress)
    end
  end # /host
end # /main

def print_record(ress)
  case ress.first
  when Resolv::DNS::Resource::IN::CNAME
    puts "CNAME, points to..."
    p ress.first.name
    puts "[ prettier: #{ress.first.name.to_s}#{ '.' if ress.first.name.absolute? } ]"
  when Resolv::DNS::Resource::IN::A
    puts "A, points to..."
    puts ress.first.address
  else
    # record not recognized...
    puts "Record not recognized: "
    p ress.first
    puts "more following:"
    p ress
  end
end # /print_status