class Users

  S_PW= 'LittlePadawan' # Super User password
  RE_PW = 'Read' # Read_only User password
  R_S = 'Super' # Role Super
  R_R = 'Regular' # Role Regular
  R_RE = 'Read_only' # Role Read_only
  USER_FILE = 'Users.txt' # File to keep Users
  
  attr_reader :text

  # Public
  def login
    puts 'Write name and password'
    name, password = gets.split.map(&:to_s)
    if password .eql? S_PW
      role = R_S
    else
      role = R_R
    end
    @current_user = [name, password, role]
  end
  
  # Only Super User
  def create_user(name, user_list)
    return puts Files::BLANK if name.nil?
    return puts Files::NOT if @current_user[2] != R_S
    self.persist
    if text .eql? "no"
      self.utemp(name, user_list)
    else
      new_user = [name, RE_PW, R_RE]
      user_list = user_list.push(new_user)
      File.open(USER_FILE, 'a+') { |f| f << "#{new_user}\n" }
    end
  end
  
  # Only Super and Regular Users
  def update_password(name)
    return puts Files::BLANK if name.nil?
    return puts Files::NOT if @current_user[2] .eql? R_RE
    @current_user[1] = name if @current_user[2] != R_RE
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
    return puts Files::BLANK if name.nil?
    return puts Files::NOT if @current_user[2] != R_S
    user_list.delete_if {|x,*_| x .eql? "#{name}"} if @current_user[2] == R_S
  end

  # Internal Use
  def persist 
    puts "Persist files? (yes or no)" 
    @text = gets.chomp
    return puts "It's a Yes or No question" unless text != "yes" || text != "no"
  end

  # Internal Use
  def utemp(name, user_list)
    new_user = [name, 'Read', R_RE]
    user_list = user_list.push(new_user)
    file = Tempfile.new(USER_FILE, Folders::PATH)
    file.write(user_list)
    file.rewind
  end
end
