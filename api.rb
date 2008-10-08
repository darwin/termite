module TermiteAPI

  class Worker < NSObject
    def reset()
      NSLog("reset!")      
    end
    
    def eat(original, current)
      current
    end
  end

  class Soldier < NSObject
    def reset()
      NSLog("reset!")      
    end
    
    def eat(original, current)
      false
    end
  end

  class Watcher < NSObject
    def reset()
      NSLog("reset!")      
    end
    
    def watch(line)
      NSLog("watch!")      
    end
  end

end