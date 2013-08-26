require 'rghost'
require 'rghost_barcode'

doc=RGhost::Document.new :rows_per_page => 7, 
  :row_height => 3.5,
  :count_pages => 5, :margin_left => 4

doc.virtual_pages do
  new_page :width => 6 
  new_page :width => 8, :margin_left => 2
end

f = File.open("#{ARGV[0]}", 'r')
f.each do |id|
  doc.barcode_code39 id.strip, :text => {:size => 10}, :scale => [0.8, 0.8]
  doc.next_row
end

doc.render :pdf, :filename => 'barcodes.pdf'
