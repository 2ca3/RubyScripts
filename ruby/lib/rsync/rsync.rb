#!/usr/bin/env ruby
require 'fileutils'

from = "./foo"
to = "./bar"

system("rsync -avn --delete #{from}/ #{to}/")
puts "-----" 
puts "Is rsync run? (y or n)" 
while str = STDIN.gets
  if str.chomp == "y" then
    break
  else
    puts "rsync is not run"
    exit
  end
end
puts "-----" 
if File.exist?("#{to}_3") then
  FileUtils.remove_entry("#{to}_3")
end
if File.exist?("#{to}_2") then
  FileUtils.mv("#{to}_2", "#{to}_3");
end
if File.exist?("#{to}_1") then
  FileUtils.mv("#{to}_1", "#{to}_2");
end
FileUtils.copy_entry(to, "#{to}_1",{:preserve => true})

system("rsync -av --delete #{from}/ #{to}/")
puts "-----" 
