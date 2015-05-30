require 'commands/create'
require 'commands/init'
require 'commands/sync'
require 'commands/start'
require 'commands/refresh'
require 'commands/rename'
require 'commands/remove'
require 'commands/list'
require 'thor'

module CommandRouter
  include Util

  class Main < Thor

    register(Init, 'init', 'init [project_name]', 'Initializes a new project.')
    register(Create, 'create', 'create [presentation_name]', 'Creates a new presentation')
    register(Sync, 'sync', 'sync [name]', 'syncs master and client.')
    register(Start,'start','start [presentation_name]','starts a presentation-server.')
    register(Refresh,'refresh','refresh [presentation_name]','refreshes the token')
    register(Remove,'remove','remove [presentation_name]', 'removes a presentation')
    register(Rename,'rename','rename [old_name] [new_name]', 'renames a presentation')
    register(List,'list','list','lists all presentations.')

  end

end
