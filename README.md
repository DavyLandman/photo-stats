Photo Stats
=================
I created this small script to extract all EXIF information about my pictures
and add it to a SQLite database so I can write some cool queries on it.

This script uses exiftool to extract the EXIF information from a wide range of
formats. The following information is extracted:

 - Lens
 - FocalLength
 - Aperture
 - ShutterSpeed
 - HyperFocalDistance

How to run
---------
 - `gem install sqlite3`
 - `gem install exiftool`
 - make sure [exiftool](http://www.sno.phy.queensu.ca/~phil/exiftool/) is
   installed
 - ruby getstats.rb "/home/davy/Pictures" stats.sqldb


TODO
---------
 - Write some code to execute the queries and generate HTML file(s) which use
   Google Chart API for some awesome graphs
 - Better interaction in the console app.
 - Find a faster way to read the exif information. (currently, 7000 6MB NEF
   files took 30 minutes to read)
