path = './system/controller/components/' 
require path + 'Error.rb'

class AccoutnsSystem 
  
  def initialize(accounts)
    
    currentUser = []
  
    @accounts = accounts

    @aNotAuthError =  "account-not-auth"
    @aWrongAuthError = "account-wrong-auth-data"
    @aNotEnoMonError = "account-not-enough-money"
    
  end 

  def signin (id, password)
    @accounts.each {|accoutnID, accountValues|
      if accoutnID == id
        if accountValues["password"] == password
          @currentUser = accountValues
          return  @currentUser["name"]
        end
      end
    }
    return Error.new(@aWrongAuthError)
  end

  def signout
    userName = @currentUser["name"]
    @currentUser = []
    return userName
  end

  def getBalance
    return @currentUser.empty? ? Error.new(@aNotAuthError): @currentUser["balance"]
  end

  def canWithdraw (value)
    return @currentUser.empty?? Error.new(@aNotAuthError) : value > @currentUser["balance"] ? Error.new(@aNotEnoMonError) : true
  end

  def withdraw (value)
    return @currentUser.empty? ? Error.new(@aNotAuthError ): @currentUser["balance"] -= value
  end

end