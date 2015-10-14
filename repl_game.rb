require "./repl_game_modules.rb"
include MainMenu

class Player
  attr_accessor :name, :gold, :health, :vma_awards
  attr_reader :swallow_velocity
  def initialize(name, fav_color, swallow_velocity, gold = 100, health = 100, vma_awards = 0)
    @name = name
    @fav_color = fav_color
    @swallow_velocity = swallow_velocity
    @gold = gold
    @health = health
    @vma_awards = vma_awards
  end
end

class Opponent
  attr_accessor :name, :health
  def initialize(name, health = (rand(50) + 5))
    @name = name
    @health = health
  end
end

# Player buys alcoholic beverages for fun and to increase health.  The game ends if the player gold reaches 0.
def tavern(player)
  cant_afford = "You only have #{player.gold} gold coins left. You can't afford that!"
  puts "Pick yer poison?"
  puts "(M)ead 10 gold coins"
  puts "(W)ine 15 gold coins"
  puts "(M)oonshine 20 gold coins"
  puts "(G)old Dragan Exlir 100 gold coins"
  puts "(L)eave the Drunken Duck"
  yer_poison = gets.chomp.downcase
  case yer_poison
  when "m"
    if player.gold >= 10
      player.gold -= 10
      if player.health <= 95
        player.health += 5
        puts "5 health restored!"
      else
        player.health == 100
        puts "Health restored!"
      end
    else
      puts cant_afford
      sleep 1
      tavern(player)
    end
  when "w"
    if player.gold >= 15
      player.gold -= 15
      if player.health <= 90
        player.health += 10
        puts "10 health restored!"
      else
        player.health == 100
        puts "Health restored!"
      end
    else
      puts cant_afford
      sleep 1
      tavern(player)
    end
  when "m"
    if player.gold >= 20
      player.gold -= 20
      if player.health <= 85
        player.health += 15
        puts "15 health restored!"
      else
        player.health == 100
        puts "Health restored!"
      end
    else
      puts cant_afford
      sleep 1
      tavern(player)
    end
  when "g"
    if player.gold >= 100
      player.gold -= 100
      player.health == 100
    else
      puts cant_afford
      sleep 1
      tavern(player)
    end
  when "l"
    puts "You suddenly don't feel thirsty anymore"
    sleep 1
    main_menu(player)
  else
    puts "#{yer_poison} is not an option. Try again."
    sleep 1
    tavern(player)
  end
  if player.gold <= 0
    puts "#{player.name} is broke as a joke!\nGAME OVER"
  else
    puts "#{player.name} has #{player.gold} gold coins remaining."
    sleep 1
    puts "#{player.name} has #{player.health} health remaining."
    sleep 1
    puts "You stumble out of the Drunken Duck feeling a little better about your situation."
    sleep 1
    main_menu(player)
  end
end

# Player gets to fight Kanye West to earn up to 60 gold coins.  The game ends if the player is defeated.
def arena(player)
  opponent = Opponent.new("Kanye West")
  puts "You are pitted against #{opponent.name}."
  puts "#{opponent.name} has #{opponent.health} health."
  sleep 1
  puts "Ready..."
  sleep 2
  puts "FIGHT!"
    loop do
      player_attack = rand(25)
      opponent.health -= player_attack
      puts "You attack #{opponent.name} and do #{player_attack} damage!"
      sleep 1
      if opponent.health <= 0
        winnings = rand(60)
        player.gold += winnings
        player.vma_awards += 1
        puts "You defeated #{opponent.name}!"
        sleep 1
        puts "\"Are you not entertained!?\", you scream at the spectators."
        sleep 1
        puts "You earned #{winnings} gold and a VMA!"
        sleep 1
        puts "#{player.name} has #{player.gold} gold coins remaining"
        puts "#{player.name} has #{player.health} health remaining"
        puts "#{player.name} has #{player.vma_awards} VMAs."
        sleep 1
        puts "Press any enter key to continue."
        continue_keypress = gets.chomp
        nil if continue_keypress
        main_menu(player)
        break
      else
        puts "#{opponent.name} has #{opponent.health} health remaining."
        sleep 2
      end
      opponent_attack = rand(15)
      player.health -= opponent_attack
      puts "#{opponent.name} attacks you and does #{opponent_attack} damage!"
      sleep 1
        if player.health <= 0
        puts "You were defeated by #{opponent.name}.\nGAME OVER."
        break
      else
        puts "#{player.name} has #{player.health} health remaining."
        sleep 2
      end
    end
end

# Player seeks advice about playing the game.  Game ends if player answered "19 mph" to the swallow question.
# Game ends if the player's gold reaches 0.  Player gets the ending of despair if oracle_wisdom is 0.
def oracle(player)
  if player.gold >= 5
    if player.swallow_velocity == "19 mph"
      player.gold += 19_000_000_000
      puts "Wise indeed is one who understands the way of the unladen swallow!"
      sleep 1
      puts "#{player.name} now has #{player.gold} gold coins."
      puts "You more gold that you can spend in several lifetimes.\nGAME OVER"
    else
      oracle_wisdom = rand(100)
      if player.health <= 20
        puts "The oracle says, \"You don't look so good. You should visit the tavern\"."
      elsif player.gold <= 20
        puts "The oracle says, \"I sense that your light on gold. You should fight in the arena\"."
      else
        if oracle_wisdom == 0
          puts "The oracle says, \"You're situation is utterly hopeless.  You are doomed to wander forever.\"\nGAME OVER"
        elsif oracle_wisdom > 0 && oracle_wisdom <= 38
          puts "The oracle says, \"Omnia mea muccum porto\"."
          sleep 1
        elsif oracle_wisdom > 38 && oracle_wisdom <= 68
          puts "The oracle says, \"Don't listen to fortune tellers. Only listen to fortune cookies\"."
          sleep 1
        elsif oracle_wisdom > 68 && oracle_wisdom <= 98
          puts "The oracle says, \"You should try walking around like a Tyrannosaurus Rex\"."
          sleep 1
        else
          puts "The oracle says, \"Did you know that an unladen swallow can fly 19 mph?\""
          sleep 1
        end
      end
    end
    if player.swallow_velocity != "19 mph"
      player.gold -= 5
      if player.gold == 0
        puts "#{player.name} is broke as a joke!\nGAME OVER"
      else
        puts "#{player.name} has #{player.gold} gold coins remaining"
        sleep 1
        main_menu(player)
      end
    end
  else
    puts "You only have #{player.gold} gold coins left. You can't afford the oracle's sage wisdom!"
  end
end



# The game beings
# Player creats a character
system("clear")
puts "What is your name?"
name = gets.chomp.to_s.strip
puts "What is your favorite color?"
fav_color = gets.chomp.to_s
puts "What is the airspeed velocity of an unladen swallow?"
swallow_velocity = gets.chomp.to_s
player = Player.new(name, fav_color, swallow_velocity)
puts "Welcome #{player.name}!"
puts "You have #{player.gold} gold coins."
puts "You have #{player.health} health."
puts "You have #{player.vma_awards} VMAs."
puts "Press any enter key to continue."
continue_keypress = gets.chomp
nil if continue_keypress

#Prologue
# puts "You have traveled far,"
# sleep 1
# puts "across barren deserts..."
# sleep 1
# puts "vast oceans..."
# sleep 1
# puts "and lush jungles..."
# sleep 1
# puts "wandering without purpose."
# sleep 1
# puts "You see a town in the distance. Weary and hungry, you enter the through the gates."
# puts "The locals cast nervous glances your way. They don't like visitors here."
# puts "Press any enter key to continue."
# continue_keypress = gets.chomp
# nil if continue_keypress

main_menu(player)
