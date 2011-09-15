MailEnvi::Config.set do |config|
  config.include_environments ['test']
  config.default_to = "configured@company.com"
end
