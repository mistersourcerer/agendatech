require 'twitter'
require 'open-uri'
require 'find'
require 'aws-sdk'

module ImageTwitterHelper
  def arquivo_para user_name
    image_url =  Twitter.user(user_name).profile_image_url
    image_name = image_url.match(/([\w_]+).(\w{3,4})$/)
    return "#{user_name}.#{image_name[2]}", image_url
  end
end

class ImageTwitter
  include ImageTwitterHelper  
  def download user_name
      nome,url_da_imagem = arquivo_para user_name
      file_path =  "#{Rails.root}/public/images/twimages/#{nome}"
      unless File.exists?(file_path)
          File.open(file_path, 'w') do |output|
            open(url_da_imagem) do |input|
                output <<  input.read            
            end
          end
      end
   end           
end

class ImageTwitterInS3
  include ImageTwitterHelper      
  
  def initialize
  	@s3 = AWS::S3.new(
      :access_key_id     => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET'])       
  end
  def download user_name  
    bucket = 'twitter_images'
    nome,url_da_imagem = arquivo_para user_name
    image = @s3.buckets[bucket].objects[nome]
    image.exists?
      image.write(open(url_da_imagem),:acl => :public_read)
    end
end
