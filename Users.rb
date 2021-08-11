SPW= 'LittlePadawan'
RePW = 'Read'
RS = 'Super'
RR = 'Regular'
RRe = 'Read_only'
USER_FILE = 'Users.txt'

class Users

  attr_reader :text

  # Public
  def login
    puts 'Write name and password'
    name, password = gets.split.map(&:to_s)
    role = RR unless password .eql? SPW
    role = RS if password .eql? SPW
    @current_user = [name, password, role]
  end
  
  # Only Super User
  def create_user(name, user_list)
    return puts BLANK if name.nil?
    return puts NOT if @current_user[2] != RS
    self.persist
    if text .eql? "no"
      self.utemp(name, user_list)
    else
      new_user = [name, RePW, RRe]
      user_list = user_list.push(new_user)
      File.open(USER_FILE, 'a+') { |f| f << "#{new_user}\n" }
    end
  end
  
  # Only Super and Regular Users
  def update_password(name)
    return puts BLANK if name.nil?
    return puts NOT if @current_user[2] .eql? RRe
    @current_user[1] = name if @current_user[2] != RRe
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
    return puts BLANK if name.nil?
    return puts NOT if @current_user[2] != RS
    user_list.delete_if {|x,*_| x .eql? "#{name}"} if @current_user[2] == RS
  end

  # Internal Use
  def persist 
    puts "Persist files? (yes or no)" 
    @text = gets.chomp
    return puts "It's a Yes or No question" unless text != "yes" || text != "no"
  end

  # Internal Use
  def utemp(name, user_list)
    new_user = [name, 'Read', RRe]
    user_list = user_list.push(new_user)
    file = Tempfile.new(USER_FILE, PATH)
    file.write(user_list)
    file.rewind
  end
end
