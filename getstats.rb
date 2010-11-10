#!/usr/bin/env ruby 
require 'sqlite3'
require 'mini_exiftool'

extensions = %w[3fr ari arw srf sr2 bay crw cr2 cap iiq eip dcs
 dcr drf k25 kdc dng erf fff mef mos mrw nef nrw orf ptx pef pxn R3D 
 raf raw rw2 raw rwl rwz x3f jpg jpeg tiff]
if ARGV.length != 2
  puts "Usage: ./getstats.rb <root directory> <sqlite db>"
  return
end

db = SQLite3::Database.new(ARGV[1])
begin
  #if the DB didn't exist, lets add the table.
  db.execute("CREATE TABLE photo_stats 
    (Filename TEXT UNIQUE, Lens TEXT, FocalLength TEXT, 
    Aperture TEXT, ShutterSpeed TEXT, HyperFocalDistance TEXT)")
rescue
end
rootdir = ARGV[0]
rootdir += "/" if rootdir[-1] != '/'
images = Dir[rootdir + "**/*.{#{extensions.join(',')}}"]
puts "Extracting information out of #{images.length} images"
add_new_image = db.prepare('INSERT INTO photo_stats VALUES (:filename, :lens, :focal, :aperture, :shutterspeed, :hyperfocaldistance)')
images.each_index do |index|
  current_image = images[index]
  ex = MiniExiftool.new(current_image)
  if not ex['Lens'].nil? and not ex['Lens'].empty?
    begin
      add_new_image.execute(:filename => current_image,
	:lens => ex['Lens'],
	:focal => ex['FocalLength'],
	:aperture => ex['Aperture'],
	:shutterspeed => ex['ShutterSpeed'],
	:hyperfocaldistance => ex['HyperFocalDistance'])
    rescue
    end
  end
  printf("%.2f%% ", (index.to_f / images.length) * 100)
  puts "" if (index % 10) == 0
end
puts "" if (images.length % 10) != 0 
add_new_image.close()
db.close()
puts "Done extracting information"

