if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Amazon S3 的配置
      :provider              => 'AWS',
      :aws_access_key_id     => ENV[AKIAJD3RIUBJYS2WSGWA],
      :aws_secret_access_key => ENV[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]
    }
    config.fog_directory     =  ENV[pickpark]
  end
end
