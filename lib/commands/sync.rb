require 'thor'
require 'thor/group'
require 'util'
require 'git'


class Sync < Thor::Group
  include Thor::Actions
  include Util

  argument :name,
           :type => :string,
           :desc => 'The presentation name',
           :required => false

  def sync

    block = Proc.new do | master,client |
      puts "syncing content for #{File.basename(master)}"
      FileUtils.cp_r "#{master}/content/",
                     "#{client}/"
    end

    @name ? presentation(@name.sub(' ','_'),&block) : each_presentation(&block)

    if git_repository?
      puts 'syncing with git...'
      add_to_git
    end
  end
end