require 'tempfile'
require 'etc'

class Files

  NOT = "Not authorized".freeze
  BLANK = "Can't be blank".freeze
  HELP = "readme.txt".freeze

  attr_reader :respuesta

  # Only Super and Regular Users
  def create_file(name, current_user)
    return puts "File exist" if File.exist?(name)
    return puts NOT if current_user[2] .eql? Users::R_RE
    puts "Write file content"
    content = gets.chomp
    self.persist
    if respuesta .eql? "no"
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
  rescue TypeError
    puts BLANK
  end

  # Public
  def metadata(name)
    puts "Last access at: #{ File.atime(name) }" 
    puts "Last modification at: #{ File.mtime(name) }"
    puts "Size file: #{ File.new(name).size } bytes"
    uid = File.stat(name).uid
    puts "Owner name: #{ Etc.getpwuid(uid).name }"
  rescue TypeError
    puts BLANK
  end

  # Only Super User
  def destroy_file(name, current_user)
    return puts "File doesn't exist" unless File.exist?(name)
    return puts NOT if current_user[2] != Users::R_S
    File.delete(name) 
  rescue TypeError
    puts BLANK
  end

  # Public
  def help
    File.foreach(HELP) { |line| puts line }
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

  # Internal Use
  def ftemp(name, content)
    file = Tempfile.new(name, Folders::PATH)
    file.write(content)
    file.rewind
  end
end
