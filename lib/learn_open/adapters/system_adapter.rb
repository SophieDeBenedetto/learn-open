require 'open3'

module LearnOpen
  module Adapters
    class SystemAdapter
      def self.open_editor(editor, path:)
        system("#{editor} .")
      end

      def self.open_login_shell(shell)
        exec("#{shell} -l")
      end

      def self.watch_dir(dir, action)
        spawn("while inotifywait -qre create,delete,move,close_write #{dir}; do #{action}; done")
      end

      def self.spawn(command, block: false)
        pid = Process.spawn(command, [:out, :err] => File::NULL)
        Process.waitpid(pid) if block
      end

      def self.run_command(command)
        system(command)
      end

      def self.run_command_with_capture(command)
        Open3.capture3(command)
      end

      def self.change_context_directory(dir)
        Dir.chdir(dir)
      end
    end
  end
end
