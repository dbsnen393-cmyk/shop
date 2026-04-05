class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick # Requires ImageMagick installed on system

  # Choose what kind of storage to use for this uploader:
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Versions defined without processing (ImageMagick not required)
  version :thumb
  version :default

  def extension_allowlist
    %w(jpg jpeg gif png)
  end
end
