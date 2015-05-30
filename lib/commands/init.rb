require 'thor'
require 'thor/group'
require 'fileutils'
require 'uri'
require 'util'

class Init < Thor::Group
  include Thor::Actions
  include Util

  def self.source_root
    File.expand_path('../',__dir__)
  end

  argument :project_name,
           :type => :string,
           :desc => 'The project name',
           :required => false


  class_option :host,
               :type => :string,
               :desc => 'host-server'

  class_option :git,
               :type => :string,
               :desc => 'initializes a git-repository'

  #TODO download latest reveal-framework. maybe rubyzip. duno
  def create_project_structure

    @host = options[:host]
    @git = options[:git]

    interactive_mode unless @host && @project_name

    @url = URI.parse "http://#{@host}"

    empty_directory "#{@project_name}/master/slides"
    empty_directory "#{@project_name}/client/slides"

    template 'template/config.yml.erb', "#{@project_name}/config.yml"
    directory 'template/reveal.js-3.0.0/', "#{@project_name}/master/"
    directory 'template/reveal.js-3.0.0/', "#{@project_name}/client/"

    if @git
      @git == 'git' ?
          init_git(@project_name) : init_git(@project_name,@git)
    end
  end

  no_commands do
    def interactive_mode
      say("so it seems that you didn't bother to give me some input. Fine. I'll ask")
      @project_name = @project_name || ask('Whats the name of the project?')

      abort('You need to specify a project name. Try again') if @project_name.empty?


      @host = @host || ask('whats the host of your token-server?(host+port)')

      abort('You need to specify a host.Try again') if @host.empty?

      unless @git
        if yes?('Do you want to use git?(y,n)')
          git_answer = ask('specify a remote (leave blank for local repository)')
          @git =
              git_answer.empty? ? 'git' : git_answer
        end
      end


    end
  end



end