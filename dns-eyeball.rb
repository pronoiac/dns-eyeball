#!/usr/bin/env ruby 

require "Resolv"
require "byebug"

# die unless ARGV.length == 2
puts "testing - google.com"
p Resolv.getaddress "www.google.com"

domain = ARGV[0] || "pronoiac.org"

# p Resolv.getaddress "www.ruby-lang.org"
# p Resolv.getname "210.251.121.214"

Resolv::DNS.open do |dns|
  # ress = dns.getresources "www.ruby-lang.org", Resolv::DNS::Resource::IN::A
  # p ress.map { |r| r.address }
  # ress = dns.getresources "ruby-lang.org", Resolv::DNS::Resource::IN::MX
  # p ress.map { |r| [r.exchange.to_s, r.preference] }
  
  puts "querying #{domain}..."
  ress = dns.getresources domain, Resolv::DNS::Resource::IN::ANY
  # byebug
  
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
  
  # byebug
end