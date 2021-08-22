require 'tmpdir'
require './services.rb'

class Folders

  include Services

  attr_reader :ans
 
  # Only Super User
  def create_folder(name, current_user)
    return puts "Folder exist" if Dir.exist?(name)
    super_user?(current_user)
    Dir.mkdir("temp") unless Dir.exist?("temp")
    persist
    if ans .eql? "no"
      Dir.mktmpdir(name, "./temp")
    else
      Dir.mkdir(name)
    end
  end
  
  # Only Super User
  def destroy_folder(name, current_user)
    return puts "Folder doesn't exist" unless Dir.exist?(name)
    super_user?(current_user)
    Dir.delete(name)
  end

  # Public
  def cd(name)
    return puts "Folder doesn't exist" unless Dir.exist?(name)
    Dir.chdir(name)
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
end
