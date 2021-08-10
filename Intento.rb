# EN FILES.RB:
require 'tempfile'
# def create_file(name, current_user) # Only Super and Regular Users
#   if current_user[2] != 'Read_only'
     text = gets.chomp
      file = Tempfile.new("puto", "/home/jesica/Desktop/ShipNow challenge/") # Path from local
        file.write("#{text}")
        file.rewind


        
        puts "#{file.read}"
        puts "#{file.path}" 
        sleep(5)
        file.close
        # file.unlink
#       else
#         puts 'Not authorized'
#       end
#     end 
#   end 
# end


File.open("#{name}.txt", "w", "/home/jesica/Desktop/ShipNow challenge/temp" ) { |f| f << "#{text}" }   


at_exit { FileUtils.remove_entry('./tmp') }
# ("./temp") } if Dir.exist?("./temp")