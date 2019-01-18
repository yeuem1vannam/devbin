# frozen_string_literal: true

require "forwardable"

module Devbin
  class Command
    extend Forwardable

    def_delegators :command, :run

    # Execute this command
    #
    # @api public
    def execute(*)
      raise(
        NotImplementedError,
        "#{self.class}##{__method__} must be implemented"
      )
    end

    # The external commands runner
    #
    # @see http://www.rubydoc.info/gems/tty-command
    #
    # @api public
    def command(**options)
      require "tty-command"
      TTY::Command.new(options)
    end

    # The cursor movement
    #
    # @see http://www.rubydoc.info/gems/tty-cursor
    #
    # @api public
    def cursor
      require "tty-cursor"
      TTY::Cursor
    end

    # Open a file or text in the user's preferred editor
    #
    # @see http://www.rubydoc.info/gems/tty-editor
    #
    # @api public
    def editor
      require "tty-editor"
      TTY::Editor
    end

    # File manipulation utility methods
    #
    # @see http://www.rubydoc.info/gems/tty-file
    #
    # @api public
    def generator
      require "tty-file"
      TTY::File
    end

    # Terminal output paging
    #
    # @see http://www.rubydoc.info/gems/tty-pager
    #
    # @api public
    def pager(**options)
      require "tty-pager"
      TTY::Pager.new(options)
    end

    # Terminal platform and OS properties
    #
    # @see http://www.rubydoc.info/gems/tty-pager
    #
    # @api public
    def platform
      require "tty-platform"
      TTY::Platform.new
    end

    # The interactive prompt
    #
    # @see http://www.rubydoc.info/gems/tty-prompt
    #
    # @api public
    def prompt(**options)
      require "tty-prompt"
      TTY::Prompt.new(options)
    end

    # Get terminal screen properties
    #
    # @see http://www.rubydoc.info/gems/tty-screen
    #
    # @api public
    def screen
      require "tty-screen"
      TTY::Screen
    end

    # The unix which utility
    #
    # @see http://www.rubydoc.info/gems/tty-which
    #
    # @api public
    def which(*args)
      require "tty-which"
      TTY::Which.which(*args)
    end

    # Check if executable exists
    #
    # @see http://www.rubydoc.info/gems/tty-which
    #
    # @api public
    def exec_exist?(*args)
      require "tty-which"
      TTY::Which.exist?(*args)
    end

    def pastel
      @pastel ||=
        begin
          require "pastel"
          Pastel.new
        end
    end

    def find_pwd(file_or_directory_name)
      current_path = Dir.pwd
      path = ["."]
      while Dir.pwd != "/"
        results = Dir[file_or_directory_name]
        unless results.empty?
          Dir.chdir current_path
          return path
        end
        path.unshift("..")
        Dir.chdir ".."      # Up one level
      end
      Dir.chdir current_path
      []
    end

    def docker_sync_file
      return @docker_sync_file if @docker_sync_file
      find_docker_files()
      @docker_sync_file
    end

    def docker_compose_file
      return @docker_compose_file if @docker_compose_file
      find_docker_files()
      @docker_compose_file
    end

    def root
      return @root if @root
      find_docker_files()
      @root
    end

    def find_docker_files
      current_path = Dir.pwd
      matched_root = ""
      matched_docker_sync_pwd = ""
      matched_docker_compose_pwd = ""
      (config["workspaces"] || {}).each_pair do |_workspace_name, value|
        root = value["root"]
        if current_path.start_with?(root) && root.length >= matched_root.length
          matched_root = root
          matched_docker_sync_pwd = value["docker-sync"]
          matched_docker_compose_pwd = value["docker-compose"]
        end
      end
      if matched_docker_sync_pwd.empty? || matched_docker_compose_pwd.empty?
        fail "Cannot find the workspace for #{current_path}"
      end
      @root = matched_root
      @docker_sync_file = matched_docker_sync_pwd.gsub(matched_root, ".")
      @docker_compose_file = matched_docker_compose_pwd.gsub(matched_root, ".")
    end

    # @deprecated
    def docker_pwd
      @docker_pwd ||=
        begin
          path = find_pwd("docker")
          if path.empty?
            fail "Cannot find the `docker' folder"
          end
          path.push("docker").join("/")
        end
    end

    def config_file_path
      @config_file_path ||= "#{Dir.home}/.config/devbin/config.yml"
    end

    def config
      return @config if @config
      require "yaml"
      @config = YAML.load_file config_file_path
    end
  end
end
