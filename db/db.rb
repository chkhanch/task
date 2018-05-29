require 'yaml'

class DB 
  def initialize (file = "db/options/config.yml")
    @config = load(file)
  end

  def load (file)
     return YAML.load_file(file)
  end

  def extract (name)
    return @config[name]
  end

  def extractAll
    return @config
  end
end