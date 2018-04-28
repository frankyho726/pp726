if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Amazon S3 的配置
      :provider              => 'AWS',
      :aws_access_key_id     => ENV[AKIAJDN22VCE7OAMVCZA],
      :aws_secret_access_key => ENV[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]
    }
    config.fog_directory     =  ENV[pickpark]
  end
end
