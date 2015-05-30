require 'util'
require 'thor/group'
require 'fileutils'
require 'nokogiri'


class Rename < Thor::Group
  include Thor::Actions
  include Util

  argument :old_name, :type => :string, :desc => 'The old name'
  argument :new_name, :type => :string, :desc => 'The new name'

  def rename

    presentation(@old_name) do |master,client|

      say "renaming #{@old_name} to #{@new_name}..."
      new_master = "#{content_root}/master/slides/#{@new_name}"
      new_client = "#{content_root}/client/slides/#{@new_name}"
      FileUtils.mv master,new_master
      FileUtils.mv client,new_client

      alter_link(File.basename(master)) do | link |
        link['href'] = "slides/#{@new_name}/"
        link.content= "#{@new_name}"
      end
    end

  end
end