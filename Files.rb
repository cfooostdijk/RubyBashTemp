require "./Users.rb" 
require "etc"

class Files

  def create_file(name, current_user) # Only Super and Regular Users
    return puts "File exist" if File.exist?("#{name}.txt")
    if current_user[2] != 'Read_only'
      text = gets.chomp
      File.open("#{name}.txt", "w") { |f| f << "#{text}" }   
    else
      puts 'Not authorized'
    end 
  end

  def show(name) # Public
    File.foreach("#{name}.txt") { |line| puts line }
    rescue Errno::ENOENT
      puts "Error"
  end

  def metadata(name) # Public
    puts "Last access at: #{ File.atime("#{name}.txt") }" 
    puts "Last modification at: #{ File.mtime("#{name}.txt") }"
    puts "Size file: #{ File.new("#{name}.txt").size } bytes"
    uid = File.stat("#{name}.txt").uid
    puts "Owner name: #{ Etc.getpwuid(uid).name }"
    rescue Errno::ENOENT
      puts "Error"
  end

  def destroy_file(name, current_user) # Only Super User
    return puts "File doesn't exist" unless File.exist?("#{name}.txt")
    if current_user[2] == 'Super'
      File.delete("#{name}.txt")
    else
      puts 'Not authorized'
    end
  end

  def help # Public
    File.foreach("readme.txt") { |line| puts line }
  end
end
