require './services.rb'

class Users

  include Services
 
  attr_reader :text

  # Public
  def login
    puts 'Write name and password'
    name, password = gets.split.map(&:to_s)
    if password .eql? Services::S_PW
      role = Services::R_S
    else
      role = Services::R_R
    end
    @current_user = [name, password, role]
  end
  
  # Only Super User
  def create_user(name, user_list)
    super_user?(current_user)
    persist
    if ans .eql? 'no'
      utemp(name, user_list)
    else
      new_user = [name, Services::RE_PW, Services::R_RE]
      user_list = user_list.push(new_user)
      File.open(Services::USER_FILE, 'a+') { |f| f << "#{new_user}\n" }
    end
  end
  
  # Only Super and Regular Users
  def update_password(name, current_user)
    auth_user?(current_user)
    @current_user[1] = name if @current_user[2] != Services::R_RE
    puts "New password: #{@current_user[1]}"
  end

  # Public
  def ls_users(user_list)
    user_list.each do |elements|
      puts elements.inspect
    end
  end

  # Public
  def who_am_i # Public
    puts "Current user is: #{@current_user}"
  end

  # Only Super User
  def destroy_user(name, user_list)
    super_user?(current_user)
    user_list.delete_if {|x,*_| x .eql? "#{name}"} if @current_user[2] == Services::R_S
  end

  # Internal Use
  def utemp(name, user_list)
    new_user = [name, 'Read', Services::R_RE]
    user_list = user_list.push(new_user)
    file = Tempfile.new(Services::USER_FILE, Services::PATH)
    file.write(user_list)
    file.rewind
  end
end
