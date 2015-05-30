require 'thor/group'
require 'util'

class Refresh < Thor::Group
  include Util
  include Thor::Actions


  argument :presentation_name,
           :type => :string,
           :desc => 'The presentation name',
           :required => false


  def refresh_presentation

    block = Proc.new do |master,client|
      say "refreshing tokens and secrets for #{File.basename(master)}"
      master = "#{master}/index.html"
      client = "#{client}/index.html"
      master_content = File.read(master)
      token = request_token
      config = parse_config
      multiplex = %Q( multiplex: {
            secret: "#{token.secret}",
            id: "#{token.socket_id}",
            url: "#{config.host}:#{config.port}"
        },
      )
      regex = /multiplex: \{.*?\},/m
      master_content.sub!(regex,multiplex)
      File.write(master, master_content)

      client_content = File.read(client)
      multiplex = %Q( multiplex: {
            secret: null,
            id: "#{token.socket_id}",
            url: "#{config.host}:#{config.port}"
        },
      )
      client_content.sub!(regex,multiplex)
      File.write(client, client_content)
    end

    @presentation_name ?
      presentation(@presentation_name,&block) : each_presentation(&block)
  end

end