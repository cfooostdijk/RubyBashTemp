require 'tmpdir'

class Folders
  
  PATH = Dir.pwd.freeze

  attr_reader :respuesta
 
  # Only Super User
  def create_folder(name, current_user)
    return puts "Folder exist" if Dir.exist?(name)
    return puts Files::NOT if current_user[2] != Users::R_S
    Dir.mkdir("temp") unless Dir.exist?("temp")
    self.persist
    if respuesta .eql? "no"
      Dir.mktmpdir(name, "./temp")
    else
      Dir.mkdir(name)
    end
  rescue TypeError
    puts Files::BLANK
  end
  
  # Public
  def cd(name)
    return puts "Folder doesn't exist" unless Dir.exist?(name)
    Dir.chdir(name)
    rescue TypeError
      puts Files::BLANK
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
    return puts Files::NOT if current_user[2] != Users::R_S
    Dir.delete(name)
    rescue TypeError
      puts Files::BLANK
  end

  # Internal Use
  def persist 
    puts "Persist files? (yes or no)" 
    text = gets.chomp
    until text == 'yes' || text == 'no'
      puts "It's a Yes or No question"
      puts "Persist files? (yes or no)" 
      text = gets.chomp
      @respuesta = text
    end
  end
end
