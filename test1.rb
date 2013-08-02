class Player 
    def initialize
        @shots = 0
        @health = 20                
    end

    def direction_of_the_road(warrior)
        if warrior.feel(:backward).wall? == true           
            @walkbackward = false
        else
            @walkbackward = true
        end
    end 

    def scan_backward(warrior)
        @go_pivot_b = warrior.feel(:backward).wall?
        @go_attack_b = warrior.feel(:backward).enemy?
        @go_rescue_b = warrior.feel(:backward).captive?
        @go_look_a_b = warrior.feel(:backward).to_s.("Archer")
        @go_look_w_b = warrior.feel(:backward).to_s.("Wizard")
    end

    def scan_forward(warrior)
        @go_pivot_f = warrior.feel.wall?
        @go_attack_f = warrior.feel.enemy?
        @go_rescue_f = warrior.feel.captive?
        @go_look_a_f = warrior.feel.to_s("Archer")
        @go_look_w_f = warrior.feel.to_s("Wizard")
    end

    def shoot_backward(warrior)
        if @go_look_w_b == true || @go_look_a_b == true
            warrior.shoot! :backward
        end    
    end

    def shoot_forward(warrior)
        if @go_look_w_f == true || @go_look_a_f == true
            warrior.shoot!
        end
    end

    #elsif warrior.health < 20 && !need_recover?(warrior)
    #    warrior.rest!        

    def play_turn(warrior)

    direction_of_the_road(warrior)
    scan_backward(warrior)
    scan_forward(warrior)
    shoot_backward(warrior)
    shoot_forward(warrior)

        if @walkbackward == true            
            if @go_pivot_b == true 
                warrior.pivot! :right
            elsif @go_attack_b == true
                warrior.attack! :backward
            elsif @go_rescue_b == true 
                warrior.rescue! :backward             
            elsif warrior.health < 20 && !need_recover?(warrior)
                warrior.rest! :backward
            else
                shoot_backward(warrior)
            end
        else 
            warrior.rest!
        end

        @health = warrior.health
    end 
    
    def need_recover?(warrior)
        warrior.health < @health
    end


end