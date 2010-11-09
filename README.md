Photo Stats
=================
I created this small script to extract all EXIF information about my pictures
and add it to a SQLite database so I can write some cool queries on it.

This script uses exiftool to extract the EXIF information from a wide range of
formats.

How to run
---------
 - `gem install sqlite3`
 - `gem install exiftool`
 - install exiftool
 - ruby getstats.rb "/home/davy/Pictures/" stats.sqldb
