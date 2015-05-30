require 'thor/group'
require 'util'
require 'fileutils'

class Remove < Thor::Group
  include Thor::Actions
  include Util


  argument :name, :type => :string, :desc => 'The presentation name'
  class_option :yes, :type => :boolean, :desc => 'do not ask'


  def remove_presentation

    presentation @name do |master,client|
      if @yes.nil?
        @yes = yes? "do you really want to delete #{File.basename(master)}?(y,N)"
      end

      if @yes
        FileUtils.rm_rf master
        FileUtils.rm_rf client
      end
    end

    alter_link(@name) do | link |
      link.parent.remove
    end

  end
end