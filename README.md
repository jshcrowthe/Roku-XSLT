Roku-XSLT
=========

This file is to be used in a Kaltura XSLT Syndicated feed. 
Via the Kaltura console create a new syndicated feed and as the feed type select Flexible Format Feed.
As the XSLT file utilitze this file and the feed will output formatted for a Roku player

I formatted the XSLT to take our feed urls (which come across as HTTPS) and convert them to HTTP
The conversion simply takes a substring of everything after the : in https:// and preserves the url (as well as
other urls that don't use HTTPS) and then appends http to the front of the string.

Works great!
