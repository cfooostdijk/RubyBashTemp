require 'tmpdir'

PATH = Dir.pwd

class Folders
 
  # Only Super User
  def create_folder(name, current_user)
    return puts "Folder exist" if Dir.exist?(name)
    return puts NOT if current_user[2] != RS
    Dir.mkdir("temp") unless Dir.exist?("temp")
    puts "Persist files? (yes or no)" 
    text = gets.chomp
    return puts "It's a Yes or No question" unless text != "yes" || text != "no"
    if text == "no"
      Dir.mktmpdir(name, "./temp")
    else
      Dir.mkdir(name)
    end
  rescue TypeError
    puts BLANK
  end
  
  # Public
  def cd(name)
    return puts "Folder doesn't exist" unless Dir.exist?(name)
    Dir.chdir(name)
    rescue TypeError
      puts BLANK
  end

  # Public
  def back_cd
    Dir.chdir("..")
  end

  # Public
  def ls
    Dir.each_child(".") {|x| puts "#{x}" }
  end

  # Public
  def where_am_i 
    puts "#{Dir.pwd}"
  end
  
  # Only Super User
  def destroy_folder(name, current_user)
    return puts "Folder doesn't exist" unless Dir.exist?(name)
    return puts NOT if current_user[2] != RS
    Dir.delete(name)
    rescue TypeError
      puts BLANK
  end
end
