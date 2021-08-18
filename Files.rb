require 'tempfile'
require 'etc'
require './services.rb'

class Files

  include Services

  attr_reader :ans

  # Only Super and Regular Users
  def create_file(name, current_user)
    return puts "File exist" if File.exist?(name)
    # return puts NOT if current_user[2] .eql? Services::R_RE
    auth_user?(current_user)
    puts "Write file content"
    content = gets.chomp
    persist 
    ftemp(name, content) if ans .eql? 'no'
    File.open(name, "w") { |f| f << content } if ans .eql? 'yes'
  rescue TypeError
    puts Services::BLANK
  end

  # Public
  def show(name)
    File.foreach(name) { |line| puts line }
  rescue TypeError
    puts Services::BLANK
  end

  # Public
  def metadata(name)
    puts "Last access at: #{ File.atime(name) }" 
    puts "Last modification at: #{ File.mtime(name) }"
    puts "Size file: #{ File.new(name).size } bytes"
    uid = File.stat(name).uid
    puts "Owner name: #{ Etc.getpwuid(uid).name }"
  rescue TypeError
    puts Services::BLANK
  end

  # Only Super User
  def destroy_file(name, current_user)
    return puts "File doesn't exist" unless File.exist?(name)
    # return puts Services::NOT if current_user[2] != Services::R_S
    super_user?(current_user)
    File.delete(name) 
  rescue TypeError
    puts Services::BLANK
  end

  # Public
  def help
    File.foreach(Services::HELP) { |line| puts line }
  end

  # Internal Use
  def ftemp(name, content)
    file = Tempfile.new(name, Services::PATH)
    file.write(content)
    file.rewind
  end
end
