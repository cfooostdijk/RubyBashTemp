require 'tempfile'
require 'etc'
require './services.rb'

class Files

  include Services

  attr_reader :ans

  # Only Super and Regular Users
  def create_file(name, current_user)
    return puts 'File exist' if File.exist?(name)
    auth_user?(current_user)
    puts 'Write file content'
    content = gets.chomp
    persist 
    ftemp(name, content) if ans .eql? 'no'
    File.open(name, 'w') { |f| f << content } if ans .eql? 'yes'
  end

  # Only Super User
  def destroy_file(name, current_user)
    return puts "File doesn't exist" unless File.exist?(name)
    super_user?(current_user)
    File.delete(name) 
  end

  # Public
  def show(name)
    return puts "File doesn't exist" unless File.exist?(name)
    File.foreach(name) { |line| puts line }
  end

  # Public
  def metadata(name)
    return puts "File doesn't exist" unless File.exist?(name)
    puts "Last access at: #{ File.atime(name) }" 
    puts "Last modification at: #{ File.mtime(name) }"
    puts "Size file: #{ File.new(name).size } bytes"
    uid = File.stat(name).uid
    puts "Owner name: #{ Etc.getpwuid(uid).name }"
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
