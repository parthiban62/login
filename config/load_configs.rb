require 'yaml'

YAML::ENGINE.yamler= 'syck'

caremonkey=YAML.load_file("config/caremonkey.yml")
Api_host=caremonkey[Rails.env]["api"]["host"]
Web_host=caremonkey[Rails.env]["web"]["host"]