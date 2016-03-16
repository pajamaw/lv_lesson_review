task :reload do |reload, print|
  puts "Reloading..." if print
  ActionDispatch::Reloader.cleanup!
  ActionDispatch::Reloader.prepare!
  true
end