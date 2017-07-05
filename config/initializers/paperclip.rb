if Rails.env.development?
  Paperclip::Attachment.default_options[:storage] = :fog
  Paperclip::Attachment.default_options[:fog_credentials] = { provider: 'Local', local_root: "#{Rails.root}/public" }
  Paperclip::Attachment.default_options[:fog_directory] = ''
  Paperclip::Attachment.default_options[:fog_host] = 'http://localhost:3000'
elsif Rails.env.production?
  Paperclip::Attachment.default_options[:storage] = :fog
  Paperclip::Attachment.default_options[:fog_credentials] = { provider: 'Local', local_root: "#{Rails.root}/public" }
  Paperclip::Attachment.default_options[:fog_directory] = ''
  Paperclip::Attachment.default_options[:fog_host] = 'http://dreamfunder-uc.herokuapp.com/'
end
