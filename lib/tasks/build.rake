# -*- encoding : utf-8 -*-
desc "Start the Redis server"
task :build => [:'assets:clean', :'assets:precompile'] do

  main_url = "http://pickwick-app.herokuapp.com"

  puts "Assets build"
  assets_dir = Rails.root.join("public","assets")
  build_dir = Rails.root.join("..","pickwick-app-ios","www")
  build_assets_dir = File.join(build_dir, "assets")

  def remove_cache_id_text(text)
    text.gsub(/-[a-z0-9]{32}/, "")
  end

  #CLEANUP
  # puts "Deleting old #{build_dir}"
  # FileUtils.rm_rf(build_dir)
  # puts "Cteating new #{build_dir}"
  # FileUtils.mkdir_p(build_dir)
  puts "Deleting old #{build_assets_dir}"
  FileUtils.rm_rf(build_assets_dir)
  puts "Cteating new #{build_assets_dir}"
  FileUtils.mkdir_p(build_assets_dir)

  puts "Creating assets build directory #{build_assets_dir}"
  FileUtils.mkdir_p(build_assets_dir)

  puts "----"

  #JAVASCRIPTS
  javascript = Dir[File.join(assets_dir,"*.js")].sort{|a,b| File.mtime(b) <=> File.mtime(a)}.first
  puts "Found javascript: #{javascript}"
  javascript_to = File.join(build_assets_dir, remove_cache_id_text(File.basename(javascript)))
  puts "CP: #{File.basename(javascript)} -> #{File.basename(javascript_to)}"
  FileUtils.cp(javascript, javascript_to)
  puts "Changing endpoint url: http://127.0.0.1:3000 -> #{main_url}"
  jsdata = File.open(javascript_to,"r:UTF-8").read.gsub("\"http://127.0.0.1:3000\"","\"#{main_url}\"")
  File.open(javascript_to, "w:UTF-8").write(remove_cache_id_text(jsdata))

  puts "----"

  #TEMPLATES
  templates = Dir[File.join(assets_dir,"templates","*.js")].sort{|a,b| File.mtime(b) <=> File.mtime(a)}.first
  puts "Found templates: #{templates}"
  templates_to = File.join(build_assets_dir, "templates", remove_cache_id_text(File.basename(templates)))
  FileUtils.mkdir(File.join(build_assets_dir, "templates"))
  puts "CP: #{File.basename(templates)} -> #{File.basename(templates_to)}"
  FileUtils.cp(templates, templates_to)

  puts "----"

  #CSS
  css = Dir[File.join(assets_dir,"*.css")].sort{|a,b| File.mtime(b) <=> File.mtime(a)}.first
  puts "Found css: #{css}"
  css_to = File.join(build_assets_dir, remove_cache_id_text(File.basename(css)))
  puts "CP: #{File.basename(css)} -> #{File.basename(css_to)}"
  FileUtils.copy(css, css_to)
  puts "Changing assets directory from /assets/ -> assets/"
  cssdata = File.open(css_to,"r:UTF-8").read.gsub("/assets/","./")
  #add fix for IOS screen
  cssdata += "body{padding-top:20px; background: #f7f8f8}.menu,#frame_detail,#frame_index{top:17px}"
  File.open(css_to, "w:UTF-8").write(remove_cache_id_text(cssdata))

  puts "----"

  #ASSETS
  puts "Found assets:"
  assets = Dir[File.join(assets_dir,"*.{svg,ttf,woff,eot,png,jpg,gif,ico}")]
  puts "Cteating new Assets in #{build_assets_dir}"
  assets.each do |asset|
    to = File.join(build_assets_dir, remove_cache_id_text(File.basename(asset)))
    puts "CP: #{File.basename(asset)} -> #{File.basename(to)}"
    FileUtils.cp(asset, to)
  end

  puts "----"

  require 'net/http'
  pid_file = Rails.root.join("tmp", "pids", "production.pid")
  puts "Starting production server"

  `rails s -p 3001 -e production -d --pid #{pid_file}`
  puts "Waiting 5 seconds for server too boot"
  sleep(2)
  index_content = Net::HTTP.get(URI('http://127.0.0.1:3001'))
  index = File.join(build_dir,"index.html")
  index_data = remove_cache_id_text(index_content.gsub("/assets/","assets/"))
  #change maps key for IOS
  index_data = index_data.gsub("AIzaSyBKXAGbk3fM-unZ22tqViYaXhriHvxnmek", "AIzaSyCBDWqE5Ve4mVv_4H84x7Ay2HjB0hjgoQA")
  File.open(index, "w:UTF-8").write(index_data)
  puts "Written #{index}"

  `kill -9 #{File.read(pid_file)}`
  File.delete(pid_file)
  puts "Killed production server"
  `open #{index}`

  puts "----"

  puts "FINISHED"
end
