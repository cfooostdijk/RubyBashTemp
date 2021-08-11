require './Users.rb'
require './Files.rb'
require './Folders.rb'

system('clear')

class Console
 
  def initialize
    @users = Users.new
    @files = Files.new
    @folders = Folders.new
  end

  def menu

    user_list = Array.new {Array.new(3)}
    current_user = @users.login

    loop do

      print "Consola$ "
      
      input, name = gets.split.map(&:to_s) 
      input = input.downcase unless input.nil?

      case input
      when 'create_file'
        @files.create_file(name, current_user)
      when 'show'
        @files.show(name)
      when 'metadata'
        @files.metadata(name)
      when 'destroy_file'
        @files.destroy_file(name, current_user)
      when 'create_folder'
        @folders.create_folder(name, current_user)
      when 'cd'
        @folders.cd(name)
      when 'cd..'
        @folders.back_cd
      when 'ls'
        @folders.ls
      when 'whereami'
        @folders.where_am_i
      when 'destroy_folder'
        @folders.destroy_folder(name, current_user)
      when 'create_user'
        @users.create_user(name, user_list)
      when 'update_password'
        @users.update_password(name)
      when 'ls_users'
        @users.ls_users(user_list)
      when 'whoami'
        @users.who_am_i
      when 'destroy_user'
        @users.destroy_user(name, user_list)
      when 'change_session'
        current_user = @users.login
      when 'help'
        @files.help
      when 'quit'
        at_exit { FileUtils.remove_entry("./temp") } if Dir.exist?("./temp")
        break
      else
        puts "Command not permitted"
      end
      puts
    end
  end

  Consola = Console.new
  Consola.menu
end
