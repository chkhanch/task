require './system/controller/Controller.rb'

class ATM  
  def initialize(config, id = rand())
    @id = id 
    @contorller = Controller.new(config)
  end

  def run 
    @contorller.run
  end
end

