# require 'carrierwave/storage/abstract'
# require 'carrierwave/storage/file'
# # require 'carrierwave/storage/fog'

<<<<<<< HEAD
# CarrierWave.configure do |config|
#   config.storage = :fog
#   config.fog_provider = 'fog/aws'
#   config.fog_credentials = {
#     provider: 'AWS',
#     aws_access_key_id: Rails.application.secrets.aws_access_key_id,
#     aws_secret_access_key: Rails.application.secrets.aws_secret_access_key,
#     region: 'ap-northeast-1'
#   }
#   config.fog_directory  = 'freemarcket-46b-image-upload'
#   config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/freemarcket-46b-image-upload'
# end
=======
CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: Rails.application.secrets.aws_access_key_id,
    aws_secret_access_key: Rails.application.secrets.aws_secret_access_key,
    region: 'ap-northeast-1'
  }
  config.fog_directory  = 'freemarket-image-uploder'
  config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/freemarket-image-uploder'
end
>>>>>>> takobiza/master
