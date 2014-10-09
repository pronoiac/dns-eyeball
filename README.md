I wanted a diagnostic tool for DNS! Also HTTP headers, to check for redirects. 

Run it: `./dns-eyeball.rb google.com`


```
$ ./dns-eyeball.rb google.com

== querying google.com...
A, points to...
74.125.239.103
fetching HTTP headers...
301 Permanent redirect: http://www.google.com/

== querying www.google.com...
A, points to...
74.125.239.115
fetching HTTP headers...
200 OK
```