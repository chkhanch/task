path = './system/controller/components/' 
require path+"Constans"

class UISystem
  include Actions
  def initialize (menus, errorsList)
    @main = menus["main"]
    @withdraw = menus["withdraw"]
    @errorsList = errorsList
  end

  def greetings(userName)
    puts "#{userName}, glad to see you!"
  end

  def farewell(userName)
    puts "#{userName}, Thank You For Using Our ATM. Good-Bye!\n"
  end

  def signin
    login = inputID("Please Enter Your Account Number: ")
    password = inputPass("Please Enter Your Passowrd: ")
    return [login, password]
  end

  def withwardMenu
    displayWithdrawMenu
    action = inputAction("Put value: ")
    case action
    when BACK_TO_MM_ACTION 
      return MAIN_MENU_ACTION
    else
      value = action.to_i
      if value > 0
        return value
      else
        return UNCORRECT_VALUE_ACTION
      end
    end
  end

  def mainMenu 
    displayMainMenu("Main Menu: ")
    action = inputAction("Please Choose From the Following Options: ")
    case action.to_i 
    when 1 
      return BALANCE_ACTION 
    when 2 
      return WITHWARD_MENU_ACTION
    when 3 
      return AUTH_ACTION 
    end
  end

  def printBalance (balance)
    puts "Your balance is #{balance}"
  end

  def printNewBalance (balance)
    puts "Your new balance is #{balance}"
  end

  def printError (error)
    errorsMsg = @errorsList[error.code]
    print "ERROR: "
    if errorsMsg.respond_to? :each
      errorsMsg.each_with_index { |(key,val), index| print "#{val}#{error.prop(index)}"}
      puts
    else
      puts errorsMsg
    end
  end

  private def displayMainMenu(title = "Menu: ")
    displayMenu(@main, title)
  end

  private def displayWithdrawMenu(title = "Menu: ")
    displayMenu(@withdraw, title)
  end

  private def displayMenu (menuItems, title)
    puts title
    menuItems.each { |keyItem, menuItem| puts " #{menuItem}" }
  end

  private def inputID(phrase = "login: ")
    print phrase
    return gets.chomp.to_i
  end

  private def inputPass(phrase = "password: ")
    print phrase
    return gets.chomp
  end

  private def inputAction (phrase = "actions: ")
    print phrase
    return  gets.chomp
  end

end