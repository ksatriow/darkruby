module PasswordCracker
    def self.password_cracker(dictionary, target_password)
      dictionary.each do |password|
        if password == target_password
          puts "Password found: #{password}"
          return password
        end
      end
      puts "Password not found in dictionary"
      nil
    end
  end
  