require "./Users.rb" 
require 'tempfile'
require "etc"

PATH = "/home/jesica/Desktop/RubyBashTemp/" # Path from local

class Files

  def create_file(name, current_user) # Only Super and Regular Users
    return puts "File exist" if File.exist?("#{name}.txt")
    if current_user[2] != 'Read_only'
      puts "Persist files? (yes or no)" 
      text = gets.chomp
      puts "Write file content"
      content = gets.chomp
      if text == "no"
        file = Tempfile.new("#{name}.txt", PATH)
        file.write("#{content}")
        file.rewind
      elsif text == "yes"
        File.open("#{name}.txt", "w") { |f| f << "#{content}" }   
      else
        puts "It's a Yes or No question"
      end
    else
      puts 'Not authorized'
    end 
  end

  def show(name) # Public
    File.foreach("#{name}") { |line| puts line }
    rescue Errno::ENOENT
      puts "Error"
  end

  def metadata(name) # Public
    puts "Last access at: #{ File.atime("#{name}") }" 
    puts "Last modification at: #{ File.mtime("#{name}") }"
    puts "Size file: #{ File.new("#{name}").size } bytes"
    uid = File.stat("#{name}").uid
    puts "Owner name: #{ Etc.getpwuid(uid).name }"
    rescue Errno::ENOENT
      puts "Error"
  end

  def destroy_file(name, current_user) # Only Super User
    return puts "File doesn't exist" unless File.exist?("#{name}")
    if current_user[2] == 'Super'
      File.delete("#{name}")
    else
      puts 'Not authorized'
    end
  end

  def help # Public
    File.foreach("readme.txt") { |line| puts line }
  end
end
