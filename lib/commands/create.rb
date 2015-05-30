require 'thor'
require 'thor/group'
require 'pathname'
require 'util'
require 'nokogiri'
require 'net/http'
require 'json'
require 'yaml'


class Create < Thor::Group
  include Thor::Actions
  include Util

  argument :name, :type => :string, :desc => 'The presentation name'

  def self.source_root
    File.expand_path('../',__dir__)
  end

  def prepare_parameters
    @snake_case_name = @name.sub ' ','_'
  end


  def create_master
    @config = parse_config
    @token = request_token
    @client = false
    template 'template/index.erb',
             "#{content_root}/master/slides/#{@snake_case_name}/index.html"

    template 'template/content.md.erb',
             "#{content_root}/master/slides/" \
             "#{@snake_case_name}/content/content.md"
  end

  def create_client
    @client = true
    template 'template/index.erb',
             "#{content_root}/client/slides/#{@snake_case_name}/index.html"
  end

  def append_index
    index = "#{content_root}/client/index.html"
    template 'template/overview_index.erb',index unless File.exist?(index)

    alter_index_html do | doc |
      unless doc.xpath('//a').map(&:content).include? @name
        body = doc.at_css 'body'
        h2 = Nokogiri::XML::Node.new 'h2', doc
        link = Nokogiri::XML::Node.new 'a', doc
        link['href'] = "slides/#{@snake_case_name}/"
        link.content= "#{@name}"
        h2 << link
        body << h2
      end
    end
  end

end