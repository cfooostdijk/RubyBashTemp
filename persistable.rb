module Persistable

  def persist 
    puts "Persist files? (yes or no)" 
    txt = gets.chomp
    until txt == 'yes' || txt == 'no'
      puts "Persist files? (yes or no)" 
      txt = gets.chomp
    end
     @ans = txt
  end
end
