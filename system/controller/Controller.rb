path = './system/controller/components/' 
require path + 'AccoutnsSystem.rb'
require path + 'cashAdapter.rb'
require path + 'UISystem.rb'
require path + 'Constans.rb'

class Controller
  
  include Actions

  def initialize (config)

    @accoutnsSystem = AccoutnsSystem.new(config["accounts"])
    @cashAdapter = CashAdapter.new(config["banknotes"])
    @uis = UISystem.new(config["menus"], config["errors"])
    @menu = AUTH_ACTION

  end

  def run 
    while true
      case @menu 
      when AUTH_ACTION
        authorization
      when MAIN_MENU_ACTION
        mainMenu
      when WITHWARD_MENU_ACTION
        withwardMenu
      end
    end     
  end

  private def mainMenu 
    result = @uis.mainMenu
    case result
    when WITHWARD_MENU_ACTION
      @menu = WITHWARD_MENU_ACTION
    when AUTH_ACTION
      userName = @accoutnsSystem.signout
      @uis.farewell(userName)
      @menu = AUTH_ACTION
    when BALANCE_ACTION 
      balance = @accoutnsSystem.getBalance
      @uis.printBalance(balance)
    end
  end
  
  private def withwardMenu
    action = @uis.withwardMenu
    case action
    when MAIN_MENU_ACTION
      @menu = action
    when UNCORRECT_VALUE_ACTION 
      @uis.printError(Error.new)
    else 
      possible = canWithdraw(action)
      if !possible.is_a?(Error)
        @cashAdapter.withdraw(action)
        newBalance = @accoutnsSystem.withdraw(action)
        @uis.printNewBalance(newBalance)
        @menu = MAIN_MENU_ACTION
      else 
        @uis.printError(possible)
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
        @menu = MAIN_MENU_ACTION
    end 

  end 

  private def canWithdraw(value)
    account = @accoutnsSystem.canWithdraw(value)
    cashAdapter = account.is_a?(Error) ? false : @cashAdapter.canWithdraw(value)
    return !cashAdapter ? account: cashAdapter.is_a?(Error) ? cashAdapter : false
  end

end