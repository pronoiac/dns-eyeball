I wanted a diagnostic tool for DNS! Also HTTP headers, to check for redirects. 
It has no dependencies, just Ruby's built-in Resolv. 

Run it: `ruby dns-eyeball.rb google.com` 
(Or `chmod +x dns-eyeball.rb` then `./dns-eyeball.rb google.com`)


```
$ ruby dns-eyeball.rb pronoiac.org

== querying pronoiac.org...
A, points to...
208.94.116.114
fetching HTTP headers...
200 OK

== querying www.pronoiac.org...
CNAME, points to...
#<Resolv::DNS::Name: pronoiac.nfshost.com.>
[ prettier: pronoiac.nfshost.com. ]
fetching HTTP headers...
200 OK
```