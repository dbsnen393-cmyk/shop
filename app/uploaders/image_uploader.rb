class ImageUploader < CarrierWave::Uploader::Base
  if Rails.env.production?
    include Cloudinary::CarrierWave

    version :thumb do
      cloudinary_transformation crop: :fill, width: 400, height: 300, gravity: :auto
    end

    version :default do
      cloudinary_transformation crop: :fill, width: 800, height: 600, gravity: :auto
    end
  else
    storage :file

    version :thumb
    version :default
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_allowlist
    %w(jpg jpeg gif png)
  end
end
