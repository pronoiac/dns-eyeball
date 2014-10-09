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
  
  case ress.first
  when Resolv::DNS::Resource::IN::CNAME
    puts "CNAME, points to..."
    p ress.first.name
    puts "testing: #{ress.first.name.to_s}#{ '.' if ress.first.name.absolute? }"
  when Resolv::DNS::Resource::IN::A
    puts "A, points to..."
    puts ress.first.address
  else
    puts "First entry not recognized."
    
  end
  
end