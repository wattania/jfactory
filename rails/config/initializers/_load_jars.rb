#require 'xls'
require "pathname"

def rec_path(path, file= false)
  path.children.collect do |child|
    if file and child.file?
      child
    elsif child.directory?
      rec_path(child, file) + [child]
    end
  end.select { |x| x }.flatten(1)
end
puts "Load JARs"
rec_path(Pathname.new(Rails.root.join "jars"), true).each{|entry|
  if entry.to_s.end_with? ".jar"
    puts "-> #{entry}"
    require entry.to_s
  end
}