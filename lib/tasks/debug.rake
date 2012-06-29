desc "Restart the app with debugging enabled, then launch the debugger"
task :debug do

  begin
    require 'debugger'
  rescue LoadError
    begin
      require 'ruby-debug'
    rescue LoadError
      puts "One of the gems 'debugger' or 'ruby-debug' must be present for this task to work"
      exit 1
    end
  end

  # This instructs the app to wait for the debugger to connect after loading
  # See config/environments/development.rb
  FileUtils.touch(File.join(Rails.root, 'tmp', 'debug.txt'))

  # Instruct Phusion Passenger to restart the app
  FileUtils.touch(File.join(Rails.root, 'tmp', 'restart.txt'))

  # Wait for it to restart (requires the user to load a page)
  puts "Waiting for restart (please reload the app in your web browser)..."
  begin
    while File.exists?(File.join(Rails.root, 'tmp', 'debug.txt'))
      sleep 0.5
    end
    sleep 1
  rescue Interrupt
    File.delete(File.join(Rails.root, 'tmp', 'debug.txt'))
    puts "\rCancelled."
    exit 1
  end

  puts "Loading debugger..."
  begin
    Debugger.start_client
  rescue Interrupt
    # Clear the "^C" that is displayed when you press Ctrl-C
    puts "\r\e[0KDisconnected."
  end

end
