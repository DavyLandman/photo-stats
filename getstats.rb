require 'rubygems'
require 'SQLite3'
require 'mini_exiftool'

extensions = %w[3fr ari arw srf sr2 bay crw cr2 cap iiq eip dcs
 dcr drf k25 kdc dng erf fff mef mos mrw nef nrw orf ptx pef pxn R3D 
 raf raw rw2 raw rwl rwz x3f jpg jpeg tiff]

db = SQLite3::Database.open('stats.sqlite')
root_dir = "c:/Users/Davy/Pictures/RAWS/"
images = Dir[root_dir + "**/*.{#{extension.join(',')}}"]
add_new_image = db.prepare('INSERT INTO xmp_stats VALUES (:filename, :lens, :focal, :aperture, :shutterspeed, :hyperfocaldistance)')
images.each_index do |index|
	img = images[index]
	ex = MiniExiftool.new(img)
	add_new_image.execute(:filename => img,
						  :lens => ex['Lens'],
						  :focal => ex['FocalLength'],
						  :aperture => ex['Aperture'],
						  :shutterspeed => ex['ShutterSpeed'],
						  :hyperfocaldistance => ex['HyperFocalDistance'])
	puts (index.to_f / images.length) * 100
end


