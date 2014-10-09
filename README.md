I wanted a diagnostic tool for DNS! Also HTTP headers, to check for redirects. 

Run it: `./dns-eyeball.rb google.com`


```
$ ./dns-eyeball.rb pronoiac.org

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