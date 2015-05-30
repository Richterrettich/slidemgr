require 'util'
require 'thor/group'

class List < Thor::Group
  include Util

  def list
    each_presentation do |master,client|
      puts "#{File.basename(master)}"
    end
  end
end