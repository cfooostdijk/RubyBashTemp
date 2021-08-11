require 'tempfile'
require 'etc'

NOT = "Not authorized"
BLANK = "Can't be blank"
HELP = "readme.txt"

class Files

  # Only Super and Regular Users
  def create_file(name, current_user)
    return puts "File exist" if File.exist?(name)
    return puts NOT if current_user[2] == RRe
    puts "Persist files? (yes or no)" 
    text = gets.chomp
    return puts "It's a Yes or No question" unless text != "yes" || text != "no"
    puts "Write file content"
    content = gets.chomp
    if text == "no"
      self.ftemp(name, content)
    else
      File.open(name, "w") { |f| f << content }   
    end
  rescue TypeError
    puts BLANK
  end

  # Public
  def show(name)
    File.foreach(name) { |line| puts line }
    rescue Errno::ENOENT
      puts "Error"
  end

  # Public
  def metadata(name)
    puts "Last access at: #{ File.atime(name) }" 
    puts "Last modification at: #{ File.mtime(name) }"
    puts "Size file: #{ File.new(name).size } bytes"
    uid = File.stat(name).uid
    puts "Owner name: #{ Etc.getpwuid(uid).name }"
    rescue Errno::ENOENT
      puts "Error"
  end

  # Only Super User
  def destroy_file(name, current_user)
    return puts "File doesn't exist" unless File.exist?(name)
    return puts NOT if current_user[2] != RS
    File.delete(name) 
  rescue TypeError
    puts BLANK
  end

  # Public
  def help
    File.foreach(HELP) { |line| puts line }
  end

  # Internal Use
  def ftemp(name, content)
    file = Tempfile.new(name, PATH)
    file.write(content)
    file.rewind
  end
end
