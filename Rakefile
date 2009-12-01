desc "Rewrite index.html using index.erb"
task :index do
  require 'erb'
  @title = "Constructor - atomicobject.github.com"
  @plugin_install = "script/plugin install git://github.com/atomicobject/constructor.git"
  @header_html = File.read("page_header.html")
  html = ERB.new(File.read("index.erb")).result(binding)
  fname = "index.html"
  File.open(fname,"w") do |f|
    f.print html
  end
  puts "Wrote #{fname}"
end

task :default => :index
