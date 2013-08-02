class Player 
    def initialize
        @shots = 0
        @health = 20                
    end

    def play_turn(warrior)                 
        #if @way_backward == true || @way_fordward == false
        if @pivot_backward == false
            if warrior.feel(:backward).captive?
                warrior.rescue! :barckward
            elsif warrior.feel(:backward).wall?
                warrior.pivot! :right
                @pivot_backward = true
            elsif warrior.feel(:backward).enemy?
                warrior.attack! :backward
            elsif warrior.feel(:backward).empty?
                if warrior.look(:backward).to_s.include?("Wizard") == true
                    warrior.shoot! :baackward
                    @shots += 1 
                elsif warrior.look.to_s.include?("Archer") == true
                    warrior.shot!
                    @shots += 1                   
                elsif warrior.health < 20 && !need_recover?(warrior)
                    warrior.rest!
                end
            elsif warrior.health < 20 && !need_recover?(warrior)
                warrior.rest!        
            else 
                warrior.walk! :backward
            end
        elsif   
            if warrior.feel.captive?
                warrior.rescue!
            elsif warrior.feel.wall?
                warrior.pivot!
            elsif warrior.feel.enemy?
                warrior.attack!
            elsif warrior.feel.empty?
                if warrior.look.to_s.include?("Wizard") == true
                    warrior.shoot! 
                    @shots += 1
                    #@pivot_backward = false                
                elsif warrior.look.to_s.include?("Archer") == true
                    warrior.shoot!
                    @shots += 1
                    #@pivot_backward = false
                elsif warrior.health < 20 && !need_recover?(warrior)
                    warrior.rest!
                end
            elsif warrior.health < 20 && !need_recover?(warrior)
                warrior.rest!
            else
                warrior.walk!
            end        
        else
            warrior.walk!        
        end    
        @health = warrior.health
    end 
    
    def need_recover?(warrior)
        warrior.health < @health
    end


end