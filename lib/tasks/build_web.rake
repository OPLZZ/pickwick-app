# -*- encoding : utf-8 -*-
require 'octokit'

desc "Build web app"
task :build_web do
  args = ENV

  unless (args['username'] || args['u']) && (args['password'] || args['p'])
    puts "Just Generation files into build/web"
    puts "For releasing new version add github `u=username p=password r=release`"
    octokit_client = nil
  else
    puts "Generating files into build/web and making release"
    # Provide authentication credentials
    Octokit.configure do |c|
      c.login = args['username'] || args['u']
      c.password = args['password'] || args['p']
    end
    github_repo = 'OPLZZ/pickwick-app'
    octokit_client = Octokit::Client.new()
    octokit_client.login
  end

  puts "Assets build"
  all_builds_dir = Rails.root.join("build")
  release_dir = all_builds_dir.join("release")
  build_dir = all_builds_dir.join("www")
  build_assets_dir = File.join(build_dir, "assets")
  assets_dir = Rails.root.join("public","assets")

  #CLEANUP
  # puts "Deleting old #{build_dir}"
  # FileUtils.rm_rf(build_dir)
  # puts "Cteating new #{build_dir}"
  # FileUtils.mkdir_p(build_dir) unless File.exists?(build_dir)
  puts "Deleting old #{build_assets_dir}"
  FileUtils.rm_rf(build_assets_dir)
  puts "Cteating new #{build_assets_dir}"
  FileUtils.mkdir_p(build_assets_dir) unless File.exists?(build_assets_dir)

  puts "Creating releasse directory #{release_dir}"
  FileUtils.mkdir_p(release_dir) unless File.exists?(release_dir)

  puts "Creating assets build directory #{build_assets_dir}"
  FileUtils.mkdir_p(build_assets_dir) unless File.exists?(build_assets_dir)

  puts "----"

  #JAVASCRIPTS
  javascript = Dir[File.join(assets_dir,"*.js")].sort{|a,b| File.mtime(b) <=> File.mtime(a)}.first
  puts "Found javascript: #{javascript}"
  javascript_to = File.join(build_assets_dir, File.basename(javascript))
  #puts "CP: #{File.basename(javascript)} -> #{File.basename(javascript_to)}"
  FileUtils.cp(javascript, javascript_to)
  jsdata = File.open(javascript_to,"r:UTF-8").read
  File.open(javascript_to, "w:UTF-8") do |fw|
    fw.write(jsdata)
  end

  puts "----"

  #TEMPLATES
  templates = Dir[File.join(assets_dir,"templates","*.js")].sort{|a,b| File.mtime(b) <=> File.mtime(a)}.first
  puts "Found templates: #{templates}"
  templates_to = File.join(build_assets_dir, "templates", File.basename(templates))
  FileUtils.mkdir(File.join(build_assets_dir, "templates"))
  #puts "CP: #{File.basename(templates)} -> #{File.basename(templates_to)}"
  FileUtils.cp(templates, templates_to)

  puts "----"

  #CSS
  css = Dir[File.join(assets_dir,"*.css")].sort{|a,b| File.mtime(b) <=> File.mtime(a)}.first
  puts "Found css: #{css}"
  css_to = File.join(build_assets_dir, File.basename(css))
  #puts "CP: #{File.basename(css)} -> #{File.basename(css_to)}"
  FileUtils.copy(css, css_to)
  puts "Changing assets directory from /assets/ -> assets/"
  cssdata = File.open(css_to,"r:UTF-8").read.gsub("/assets/","./")
  File.open(css_to, "w:UTF-8") do |fw|
    fw.write(cssdata)
  end

  puts "----"

  #ASSETS
  puts "Found assets:"
  assets = Dir[File.join(assets_dir,"*.{svg,ttf,woff,eot,png,jpg,gif,ico}")]
  puts "Cteating new Assets in #{build_assets_dir}"
  assets.each do |asset|
    to = File.join(build_assets_dir, File.basename(asset))
    #puts "CP: #{File.basename(asset)} -> #{File.basename(to)}"
    FileUtils.cp(asset, to)
  end

  puts "----"

  require 'net/http'
  pid_file = Rails.root.join("tmp", "pids", "production.pid")
  puts "Starting production server"

  `rails s -p 3001 -e production -d --pid #{pid_file}`
  puts "Waiting 5 seconds for server too boot"
  sleep(5)
  index_content = Net::HTTP.get(URI('http://127.0.0.1:3001'))
  index = File.join(build_dir,"index.html")
  index_data = index_content.force_encoding('utf-8').gsub("/assets/","assets/")
  File.open(index, "w:UTF-8") do |fw|
    fw.write(index_data)
  end
  puts "Written #{index}"

  `kill -9 #{File.read(pid_file)}`
  File.delete(pid_file)
  puts "Killed production server"

  puts "----"
  #create releases only if logged to github
  if octokit_client
    puts "Getting releases from github"
    github_releases = octokit_client.releases(github_repo)
    release_count = github_releases.size
    puts "Release count is #{release_count}"
    release_count += 1
    formated_release = "v" +("#{release_count < 10 ? "0#{release_count}" : release_count}".to_s.reverse.gsub(/.(?=.)/,'\&.').reverse)
    puts "and transformed to new version: #{formated_release}"

    puts "Packing build into build/release.tar.gz"
    release_file = "#{release_dir}/release.tar.gz"
    `cd #{all_builds_dir} && tar -pczf #{release_file} www`

    latest_commit_sha = octokit_client.commits(github_repo).first.sha

    latest_tag_sha = ""
    if latest_tag = octokit_client.tags(github_repo).first
      latest_tag_sha = latest_tag.commit.sha
    end
    if latest_tag_sha == latest_commit_sha
      puts "Already existing Tag #{latest_tag.name} for lates commit, just updating relase file"
      release = github_releases.find{|r| r.tag_name == latest_tag.name}
      release_id = release.id
      puts "Found release id #{release_id}"
      if release.assets.size > 0
        release.assets.each do |asset|
          puts "Found existing asset id #{asset.id} - deleting it!"
          octokit_client.delete_release_asset "/repos/#{github_repo}/releases/assets/#{asset.id}"
        end
      end
    else
      puts "Tagging github repo #{formated_release} and creating new release"
      release = octokit_client.create_release(github_repo, formated_release)
      release_id = release.id
    end
    puts "Uploading release asset to #{release_id}"
    octokit_client.upload_asset("/repos/#{github_repo}/releases/#{release.id}", release_file)

    # pp octokit_client.releases(github_repo).first.sha

  end
  puts "FINISHED WEB GENERATION"
end
