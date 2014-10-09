#!/usr/bin/env ruby 

require "Resolv"
require "byebug"

# die unless ARGV.length == 2
puts "testing - google.com"
p Resolv.getaddress "www.google.com"

domain = ARGV[0] || "pronoiac.org"

Resolv::DNS.open do |dns|

  puts "querying #{domain}..."
  ress = dns.getresources domain, Resolv::DNS::Resource::IN::ANY
  
  byebug
  
  print_record(ress)
end # /main

def print_record(ress)
  if ress.count == 0
    print "No records returned!"
    return false
  end
  
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
  end
end # /print_status