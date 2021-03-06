module Services

  S_PW= 'LittlePadawan'.freeze # Super User password
  RE_PW = 'Read'.freeze # Read_only User password
  R_S = 'Super'.freeze # Role Super
  R_R = 'Regular'.freeze # Role Regular
  R_RE = 'Read_only'.freeze # Role Read_only

  PERSIST = 'Persist files? (yes or no)'.freeze
  NOT = "Not authorized".freeze
  USER_FILE = 'Users.txt'.freeze # File to keep Users
  HELP = "readme.txt".freeze
  PATH = Dir.pwd.freeze

  def persist 
    puts PERSIST
    txt = gets.chomp
    until txt == 'yes' || txt == 'no'
      puts PERSIST
      txt = gets.chomp
    end
     @ans = txt
  end

  def super_user?(current_user)
    if current_user[2] != R_S
      puts NOT 
      exit
    end
  end

  def auth_user?(current_user)
    if current_user[2] .eql? R_RE
      puts NOT
      exit
    end
  end

  def name?(name)
    if name.nil?
      puts "Can't be blank"
      exit
    end
  end
end

# Rescatar errores
# Reducir lo de autenticacion de usuarios
# Ver que si no es user, me kickea (hacer que vuelva al menu)
# Hacer un register para usuarios 
