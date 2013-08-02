class Player 
    def initialize
        @shoots = 0
        @health = 20
        @sense = :forward               
    end

    def rescue_captive(warrior)
        if warrior.feel(@sense).captive?
            warrior.rescue! (@sense)
        end 
    end
    
    def go_attack?(warrior)
        if warrior.feel(@sense).enemy?
            warrior.attack! (@sense)
        end
    end 

    def has_an_archer_ahead?(warrior)
        if warrior.look(@sense).to_s.include?("Archer") 
            @archer_ahead = true                                    
        end           
    end 

    def has_an_wizard_ahead?(warrior)
        if warrior.look(@sense).to_s.include?("Wizard")
            @Wizard_ahead = true        
        end
    end

    def shoot_arch(warrior)
        if @Wizard_ahead || @archer_ahead
            warrior.shoot! (@sense)
        end 
    end

    def empty?(warrior)
        if warrior.feel(@sense).empty?
            has_an_archer_ahead?(warrior)
            has_an_wizard_ahead?(warrior)                 
            walk?(warrior)       
        else 
            shoot_arch(warrior)
        end        
    end

    def walk?(warrior)
        if empty?(warrior) == false
            warrior.walk!(@sense)
        end
    end   

    def recover(warrior)
        if warrior.health < 20 && !need_recover?(warrior)
            warrior.rest!
        end
    end
    
    def pivot(warrior)        
        if warrior.feel.wall?
            warrior.pivot!         
        end            
    end

    def play_turn(warrior)
                      
        empty?(warrior)
        rescue_captive(warrior)
        shoot_arch(warrior)
        recover(warrior)
        pivot(warrior)
        go_attack?(warrior)
        has_an_archer_ahead?(warrior)
        has_an_wizard_ahead?(warrior)
        walk?(warrior)

        @health = warrior.health
 
    end 
    
    def need_recover?(warrior)
        warrior.health < @health
    end

end