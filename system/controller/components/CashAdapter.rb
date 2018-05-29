path = './system/controller/components/' 
require path + 'Error.rb'

class CashAdapter

  def initialize(cash, limit = -1)

    @bufferState = []

    @cLimitWdEror = "balance-limit"
    @cNodeWdEror = "balance-bills"

    @notes = cash.keys
    @cash = cash.select { |node, count| count > 0 }
    @maxLimit = limit 
    @currentLimit = @maxLimit < 0 ? calcLimit(@cash): @maxLimit 
  end

  def withdraw (value)
    @cash = @bufferState
    @bufferState = []
    newLimit = calcLimit(@cash)
    @currentLimit = @maxLimit < newLimit ? newLimit: @maxLimit
  end

  def canWithdraw (value)

    if value > @currentLimit && @currentLimit != 0 
      return Error.new(@cLimitWdEror, [@currentLimit])
    end

    cash = @cash.clone  
    calc = changecash(value, cash) 
    result = calc ? calc : []

    if result[0] == 0 
      @bufferState = result[1]
      return true
    else
      return Error.new(@cNodeWdEror)
    end

  end

  private def update(cash)
     return cash.select { |node, count| count > 0 }
  end

  private def changecash (value, cash)
    possible = false
    if value > 0 && !cash.empty?
      cash.detect { |node, val| 
        if node <= value
          value -= node
          cash[node] -= 1
          cash = update(cash)
          possible = true
        end
      }
      possible ? changecash(value, cash): false
    else
      return [value, cash]
    end
  end

  private def calcLimit(cash)
    return !cash.empty? ? cash.reduce(0) { |sum, (node, count)| sum + node * count }: 0
  end

end