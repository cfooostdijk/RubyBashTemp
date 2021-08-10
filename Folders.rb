require 'tmpdir'

class Folders

  def create_folder(name, current_user) # Only Super User
    return puts "Folder exist" if Dir.exist?(name)
    if current_user[2] == 'Super'
      puts "Persist files? (yes or no)" 
      text = gets.chomp
      if text == "no"
        Dir.mkdir("temp") unless Dir.exist?("temp")
        Dir.mktmpdir(name, "./temp")
      elsif text == "yes"
        Dir.mkdir(name)
      else
        puts "It's a Yes or No question"
      end
    else
      puts 'Not authorized'
    end
    rescue TypeError
      puts "Can't be blank"
  end

  def cd(name) # Public
    return puts "Folder doesn't exist" unless Dir.exist?(name)
    Dir.chdir(name)
    rescue TypeError
      puts "Can't be blank"
  end

  def back_cd # Public
    Dir.chdir("..")
  end

  def ls # Public
    Dir.each_child(".") {|x| puts "#{x}" }
  end

  def where_am_i # Public
    puts "#{Dir.pwd}"
  end

  def destroy_folder(name, current_user) # Only Super User
    return puts "Folder doesn't exist" unless Dir.exist?(name)
    if current_user[2] == 'Super'
      Dir.delete(name)
    else
      puts 'Not authorized'
    end
    rescue TypeError
      puts "Can't be blank"
  end
end
