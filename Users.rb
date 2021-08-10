NAME = 'Cris'
PASSWORD = 'Cris'
ROLE = 'Super'

class Users

  def login # Public
    puts 'Write name and password'
    name, password = gets.split.map(&:to_s)
    if name == NAME && password == PASSWORD
      role = ROLE
    elsif password == 'Read'
      role = 'Read_only'
    else
      role = 'Regular'
    end
    puts
    @current_user = [name, password, role]
  end
   
  def create_user(name, user_list) # Only Super User
    return puts "Can't be blank" if name.nil?
    if @current_user[2] == 'Super'
      new_user = [name, 'Read', 'Read_only']
      user_list = user_list.push(new_user)
      File.open("Users.txt", 'a+') { |f| f << "#{new_user}\n" }
    else
      puts 'Not authorized'
    end
  end

  def update_password(name) # Only Super and Regular Users
    return puts "Can't be blank" if name.nil?
    if @current_user[2] != 'Read_only'
      @current_user[1] = name
      puts "New password: #{@current_user[1]}"
    else
      puts 'Not authorized'
    end
  end

  def ls_users(user_list) # Public
    user_list.each do |elements|
      puts elements.inspect
    end
  end

  def who_am_i # Public
    puts "Current user is: #{@current_user}"
  end

  def destroy_user(name, user_list) # Only Super User
    return puts "Can't be blank" if name.nil?
    if @current_user[2] == 'Super'
      user_list.delete_if {|x,*_| x == "#{name}"}
    else
      puts 'Not authorized'
    end
  end
end
