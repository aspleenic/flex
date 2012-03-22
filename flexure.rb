#!/usr/bin/env ruby

class Flexure
 def connect(args)
   if !args.empty? and args.length == 2
     src, dest = args
     dest = dest.chomp
     if dest.match(/:[\w\/]*$/)
       dest =~ /:([\w\/]*$)/ and file_path = $1
       puts "Attempting to create directory with: ssh #{extract_host(dest)} 'mkdir -p #{file_path}'"
       %x{ssh #{extract_host(dest)} 'mkdir -p #{file_path}'}
     end
     puts "hi"
     puts "Attempting to connect with: scp #{correct_hostname(src)} #{correct_hostname(dest)}"
     exec "scp #{correct_hostname(src)} #{correct_hostname(dest)}"
   else
     puts "Usage: flscp [copied ssh arg]"
     puts "Ex: flscp file.txt ssh://blahblah@ec3-71-121-239-226.compute-1.amazonaws.com:/root/"
     puts "Ex: flscp ssh://blahblah@ec3-71-121-239-226.compute-1.amazonaws.com:/root/file.txt ./"
   end
 end
 
 def correct_hostname(host)
   host = host.gsub(/ssh:\/\/\w*/, 'root')
 end
 
 def extract_host(host)
   host = correct_hostname(host.gsub(/:[\w\/]*$/, ''))
 end
end

finally = Flexure.new
finally.connect(ARGV)