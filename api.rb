module TermiteAPI

  class Worker
    def reset()
      NSLog("reset!")      
    end
    
    def eat(original, current)
      current
    end
  end

  class Soldier
    def reset()
      NSLog("reset!")      
    end
    
    def eat(original, current)
      false
    end
  end

  class Watcher
    def reset()
      NSLog("reset!")      
    end
    
    def watch(line)
      NSLog("watch!")      
    end
  end

end