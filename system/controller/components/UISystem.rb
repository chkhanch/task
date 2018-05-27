class UISystem
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
    displayWithdraw
    action = inputAction("Put value: ")
    case action
    when 'b'
      return "main"
    else
      value = action.to_i
      if value > 0
        return value
      else
        return "incorrectValue"
      end
    end
  end

  def mainMenu 
    displayMainMenu("Main Menu: ")
    action = inputAction("Please Choose From the Following Options: ")
    case action.to_i 
    when 1 
      return "balance"
    when 2 
      return "withward"
    when 3 
      return "authorization"
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

  private def displayWithdraw(title = "Menu: ")
    displayMenu(@withdraw, title)
  end

  private def displayMenu (menuItems, title)
    puts title
    menuItems.each { |keyItem, menuItem| puts " #{menuItem}" }
  end

  private def inputID(pharse = "login: ")
    print pharse
    return gets.chomp.to_i
  end

  private def inputPass(pharse = "password: ")
    print pharse
    return gets.chomp
  end

  private def inputAction (pharse = "actions: ")
    print pharse
    return  gets.chomp
  end

end