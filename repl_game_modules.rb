module MainMenu
  # Gives the player choice of activities in the town or the option to leave and end the game
  def main_menu(player)
    puts "What would you like to do?"
    puts "(V)isit the tavern"
    puts "(F)ight in the arena"
    puts "(S)peak to the oracle"
    puts "(C)heck status"
    puts "(L)eave town"
    main_menu_choice = gets.chomp.downcase
    case main_menu_choice
    when "v"
      system("clear")
      puts "You spot a sign: 'The Drunken Duck'"
      puts "'I need drink', you think to yourself as you make a beeline for the tavern."
      sleep 1
      tavern(player)
    when "f"
      system("clear")
      puts "Hoping to earn some coins, you march confidently to the arena."
      sleep 1
      arena(player)
    when "s"
      system("clear")
      puts "You decide to seek the oracle's sage advice about your present situation."
      sleep 1
      oracle(player)
    when "c"
      system("clear")
      puts "#{player.name} has #{player.gold} gold coins."
      sleep 1
      puts "#{player.name} has #{player.health} health."
      sleep 1
      puts "#{player.name} has #{player.vma_awards} VMAs."
      sleep 1
      main_menu(player)
    when "l"
      system("clear")
      puts "'This town smells like shit', you grumble as return to the road."
      sleep 1
      puts "#{player.name} has #{player.gold} gold coins."
      sleep 1
      puts "#{player.name} has #{player.health} health."
      sleep 1
      puts "#{player.name} has #{player.vma_awards} VMAs."
      sleep 1
      puts "GAME OVER"
      exit
    else
      puts "That is not an option.  Try again"
      sleep 1
      main_menu(player)
    end
  end
end
