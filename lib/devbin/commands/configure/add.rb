# frozen_string_literal: true

require_relative '../../command'
require "yaml"

module Devbin
  module Commands
    class Configure
      class Add < Devbin::Command
        require "yaml"
        require "erb"
        require "tty-file"
        require "ostruct"

        def initialize(app_name, options)
          @app_name = app_name
          @options = options
        end

        def execute(input: $stdin, output: $stdout)
          check_or_create_config_files()
          root_dir = ask_for_root()
          puts root_dir
          docker_sync_file = ask_for_docker_sync_file()
          puts docker_sync_file
          docker_compose_file = ask_for_docker_compose_file()
          puts docker_compose_file
          add_new_config(
            root_dir:             root_dir,
            docker_sync_file:     docker_sync_file,
            docker_compose_file:  docker_compose_file
          )
          add_new_docker_sync(
            root_dir:             root_dir,
            docker_sync_file:     docker_sync_file
          )
          add_new_docker_compose(
            root_dir:             root_dir,
            docker_compose_file:  docker_compose_file
          )

          output.puts pastel.yellow.bold("OK")
        end

        private

        def check_or_create_config_files
          unless File.exist? config_file_path
            tree = {
              ".config" => [
                "devbin" => []
              ]
            }
            TTY::File.create_dir tree, Dir.home
            TTY::File.copy_file "lib/devbin/templates/configure/add/config.yml", config_file_path
          end
        end

        def ask_for_root(output: $stdout)
          msg = pastel.yellow "Is `", pastel.bold(Dir.pwd), "' the root dir of workspace?"
          if prompt.yes? msg
            Dir.pwd
          else
            output.puts pastel.red "Please navigate to the workspace's root dir and try again"
            exit 1
          end
        end

        def ask_for_docker_sync_file(output: $stdout)
          default_path = "#{Dir.pwd}/docker-sync.yml"

          if File.exist? default_path
            output.puts pastel.green(
              "Detected the docker-sync configuration file at ",
              pastel.bold(default_path),
              ". Good to go"
            )
            return default_path.gsub(Dir.pwd, ".")
          end

          msg = pastel.yellow "./docker-sync.yml not found"
          choices = [
            { key: "1", name: "Create new file ./docker-sync.yml", value: :new },
            { key: "2", name: "I will give you a path", value: :input },
            { key: "3", name: "Abort", value: :stop },
          ]
          select_value = prompt.select msg, choices
          case select_value
          when :new
            variables = OpenStruct.new
            variables[:app_name] = @app_name
            variables[:app_root] = "#{Dir.pwd}/#{@app_name}"
            source_file = "lib/devbin/templates/configure/add/docker-sync.yml.erb"
            TTY::File.copy_file source_file, default_path, context: variables 
            default_path.gsub(Dir.pwd, ".")
          when :input
            output.puts pastel.red "Implementing: ask for docker-sync.yml path"
          when :stop
            output.puts pastel.red "Abort"
            exit 1
          else
            fail "Un-handled select option"
          end
        end

        def ask_for_docker_compose_file
          "./docker-compose.yml"
        end

        # @example
        #   add_new_config(
        #     root_dir:             "/Users/yeuem1vannam/awesome-project",
        #     docker_sync_file:     "./docker-sync.yml",
        #     docker_compose_file:  "./docker-compose.yml"
        #   )
        #   # =>
        #   # ~/.config/devbin/config.yml
        #   # workspaces:
        #   #   awesome-project:
        #   #     root:           /Users/yeuem1vannam/awesome-project
        #   #     docker-sync:    ./docker-sync.yml
        #   #     docker-compose: ./docker-compose.yml
        def add_new_config(root_dir:, docker_sync_file:, docker_compose_file:)
          config = YAML.load_file config_file_path
          workspace = Dir.pwd.split("/").last
          app_config = {
            "root" => root_dir,
            "docker-sync" => docker_sync_file,
            "docker-compose" => docker_compose_file
          }
          config["workspaces"] ||= {}
          config["workspaces"][workspace] ||= {}
          config["workspaces"][workspace][@app_name] = app_config
          File.open(config_file_path, "w") do |f|
            f.write config.to_yaml
          end
        end 

        # Add new section to docker-sync.yml file
        def add_new_docker_sync(root_dir:, docker_sync_file:)
          file_path = File.join(root_dir, docker_sync_file)
          config = YAML.load_file file_path
          config["syncs"]["#{@app_name}-sync"] = {
            "src" => "#{root_dir}/#{@app_name}",
            "sync_excludes" => [".git", "node_modules"]
          }
          File.open(file_path, "w") do |f|
            f.write config.to_yaml
          end
        end

        # Add new section to docker-compose.yml file
        def add_new_docker_compose(root_dir:, docker_compose_file:)
          file_path = File.join(root_dir, docker_compose_file)

          template_file = "lib/devbin/templates/configure/add/docker-compose.yml.erb"
          app_name = @app_name
          yaml_string = ERB.new(File.read(template_file)).result binding
          app_config = YAML.load(yaml_string)

          config = YAML.load_file file_path
          config["services"].merge! app_config["services"]
          config["volumes"].merge! app_config["volumes"]

          File.open(file_path, "w") do |f|
            f.write config.to_yaml
          end
        end
      end
    end
  end
end
