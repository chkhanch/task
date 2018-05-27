require './system/ATM.rb'
require './db/db.rb'

db = ARGV.first ? DB.new(ARGV.first) : DB.new
config = db.extractAll

atm = ATM.new config 

atm.run

