require 'image_processing/mini_magick'

class User::PhotoUploader < Shrine
  include ImageProcessing::MiniMagick
  plugin :delete_raw
  plugin :determine_mime_type
  plugin :processing
  plugin :versions

  process(:store) do |io, context|
    original = io.download

    big = resize_to_fill!(original, 300, 300, gravity: 'Center')
    chip = resize_to_fill(big, 50, 50, gravity: 'Center')

    { original: io, big: big, chip: chip }
  end
end
