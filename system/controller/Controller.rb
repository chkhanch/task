path = './system/controller/components/' 
require path + 'AccoutnsSystem.rb'
require path + 'cashAdapter.rb'
require path + 'UISystem.rb'

class Controller

  def initialize (config)

    @accoutnsSystem = AccoutnsSystem.new(config["accounts"])
    @cashAdapter = CashAdapter.new(config["banknotes"])
    @uis = UISystem.new(config["menus"], config["errors"])
    @menu = "authorization"

  end

  def run 
    while true
      case @menu 
      when "authorization" 
        authorization
      when "main"
        mainMenu
      when "withward" 
        withwardMenu
      end
    end     
  end

  private def mainMenu 
      resulte = @uis.mainMenu
      case resulte
      when "withward"
          @menu = resulte
      when "authorization"
          userName = @accoutnsSystem.signout
          @uis.farewell(userName)
          @menu = resulte
      when "balance"
          balance = @accoutnsSystem.getBalance
          @uis.printBalance(balance)
      end
  end
  
  private def withwardMenu
      action = @uis.withwardMenu
      case action
      when "main"
          @menu = action
      when "incorrectValue"
          @uis.printError(Error.new)
      else 
          posiable = canWithdraw(action)
          if !posiable.is_a?(Error)
              @cashAdapter.withdraw(action)
              newBalance = @accoutnsSystem.withdraw(action)
              @uis.printNewBalance(newBalance)
              @menu = "main"
          else 
              @uis.printError(posiable)
          end
      end
  end

  private def authorization 

      accountInfo = @uis.signin
      login = accountInfo[0]
      password = accountInfo[1]
      logged =  @accoutnsSystem.signin(login, password)  
      if logged.is_a?(Error)
          @uis.printError(logged)
      else
          @uis.greetings(logged)
          @menu = "main"
      end 

  end 

  private def canWithdraw(value)
      account = @accoutnsSystem.canWithdraw(value)
      cashAdapter = account.is_a?(Error) ? false : @cashAdapter.canWithdraw(value)
      return !cashAdapter ? account: cashAdapter.is_a?(Error) ? cashAdapter : false
  end

end