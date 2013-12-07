# -*- encoding : utf-8 -*-

desc "Start the Redis server"
task :build => :'assets:precompile' do
#task :build do
  puts "Assets build"
  assets_dir = Rails.root.join("public","assets")
  build_dir = Rails.root.join("build")

  puts "Deleting old #{build_dir}"
  FileUtils.rm_rf(build_dir)
  puts "Cteating new #{build_dir}"
  FileUtils.mkdir_p(build_dir)


  javascript = Dir[File.join(assets_dir,"*.js")].sort{|a,b| File.mtime(b) <=> File.mtime(a)}.first
  puts "Found javascript: #{javascript}"
  templates = Dir[File.join(assets_dir,"templates","*.js")].sort{|a,b| File.mtime(b) <=> File.mtime(a)}.first
  puts "Found templates: #{templates}"
  css = Dir[File.join(assets_dir,"*.css")].sort{|a,b| File.mtime(b) <=> File.mtime(a)}.first
  puts "Found css: #{css}"

  puts "Found assets:"
  assets = Dir[File.join(assets_dir,"*.{svg,ttf,woff,eot,png,jpg,gif,ico}")]

  build_assets_dir = File.join(build_dir, "assets")
  puts "Cteating new Assets in #{build_assets_dir}"
  FileUtils.mkdir_p(build_assets_dir)



  javascript_to = File.join(build_assets_dir, File.basename(javascript))
  puts "CP: #{javascript} -> #{javascript_to}"
  FileUtils.cp(javascript, javascript_to)

  templates_to = File.join(build_assets_dir, "templates", File.basename(templates))
  FileUtils.mkdir(File.join(build_assets_dir, "templates"))
  puts "CP: #{templates} -> #{templates_to}"
  FileUtils.cp(templates, templates_to)

  css_to = File.join(build_assets_dir, File.basename(css))
  puts "CP: #{css} -> #{css_to}"
  FileUtils.copy(css, css_to)

  assets.each do |asset|
    to = File.join(build_assets_dir, File.basename(asset))
    puts "CP: #{asset} -> #{to}"
    FileUtils.cp(asset, to)
  end

  index_content = "
  <!DOCTYPE html>
    <html>
    <head>
      <title>PickwickApp</title>
      <link href='assets/#{File.basename(css)}' media='all' rel='stylesheet'>
      <script data-turbolinks-track='false' src='http://j.maxmind.com/app/geoip.js'></script>
      <script data-turbolinks-track='false' src='assets/#{File.basename(javascript)}'></script>
      <meta name='viewport' content='width=device-width, initial-scale=1, maximum-scale=1'>
    </head>
    <body>
    </body>
  </html>
  "
  index = File.join(build_dir,"index.html")
  File.open(index, "w:UTF-8").write(index_content)
  puts "Written #{index}"

  `open #{index}`
end
