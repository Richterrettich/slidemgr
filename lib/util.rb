require 'pathname'
require 'git'
require 'net/http'
require 'json'
require 'yaml'

module Util
  Token = Struct.new(:socket_id,:secret)
  Config = Struct.new(:host,:port,:project_name)
  def content_root
    return @root_dir if @root_dir
    search_dir = Dir.pwd
    while search_dir && !File.exist?("#{search_dir}/config.yml")
      parent = File.dirname(search_dir)
      # project_root wird entweder der Root-pfad oder false. Wenn es false
      # wird, bricht die Schleife ab. Vgl. Rails
      search_dir = (parent != search_dir) && parent
    end
    project_root = search_dir if File.exist? "#{search_dir}/config.yml"
    raise 'you are not within a presentation-project.' unless project_root
    @root_dir = Pathname.new(File.realpath project_root)
  end


  def parse_config
    config = YAML.load_file("#{content_root}/config.yml")
    Config.new(config['host'],config['port'],config['project_name'])
  end

  def request_token
    host = parse_config.host
    puts "request token from: http://#{host}"
    hash = JSON.parse(Net::HTTP.get(host, '/token'))
    Token.new(hash['socketId'],hash['secret'])
  end


  def each_presentation(&block)
    path = "#{content_root}/master/slides"
    Dir.entries(path)
        .select { |entry| !entry.start_with? '.'}
        .each{ | entry | presentation(entry,&block) }
  end


  def presentation(name,&block)
    master_path = "#{content_root}/master/slides/#{name}"
    client_path = "#{content_root}/client/slides/#{name}"
    block.call master_path,client_path
  end


  def alter_index_html
    index = "#{content_root}/client/index.html"
    doc = nil
    File.open index,"r+" do |file|
      doc = Nokogiri::HTML(file)
      yield doc
    end
    File.open(index,'w+') { |file| file.write(doc.to_html)} if doc
  end

  def alter_link(name)
    alter_index_html do | doc |
      link   = doc.search(%Q(a[href="slides/#{name}/"])).first
      yield link
    end
  end

  # git stuff

  def git_repository?
    File.exist? "#{content_root}/.git"
  end

  def init_git(project_path,remote=nil)
    g = Git.init project_path
    g.add_remote 'origin',remote if remote
  end

  def add_to_git
    g = Git.open content_root
    g.add(:all=>true)
    g.commit('autocommit')
    g.push(g.remote('origin'),opts = {force: true}) if has_remote?(g)

  rescue Git::GitExecuteError => error
    puts error.message.split(":")[1]
  end

  def has_remote?(git)
    git.remotes.count > 0
  end

  def pull_from_git(path)
    g = Git.open(path)
    g.pull('origin','master')
  end
end