require 'thor/group'
require 'util'
require 'webrick'
require 'launchy'


class Start < Thor::Group
  include Util

  class_option :port,
               :type => :numeric,
               :desc => "the server-port",
               :default => 8080

  argument :presentation_name,
           :type => :string,
           :desc => 'The name of the presentation',
           :required => false

  def start
    root = "#{content_root}/master"
    thr = Thread.new do
      server =
          WEBrick::HTTPServer.new :Port => options[:port], :DocumentRoot => root
      trap 'INT' do server.shutdown end
      server.start
    end
    if @presentation_name
      Launchy.open("http://localhost:#{options[:port]}/slides/#{@presentation_name}")
    else
      Launchy.open("http://localhost:#{options[:port]}/slides/")
    end
    thr.join
  end

end