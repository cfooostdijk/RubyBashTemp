class Persisted

  def persist
    puts "Persist files? (yes or no)" 
    @text = gets.chomp
    if @text == "no"
      Dir.mkdir("temp") unless Dir.exist?("temp")
    elsif
      @text == "yes"
      return
    end

    puts @text
  end

end