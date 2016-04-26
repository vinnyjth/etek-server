  require "erb"

  class WheneverWriter

    attr_accessor :commands

    def initialize(commands = [], file_path="./config/schedule.rb")
      @commands = commands
      @file_path = file_path
    end

    def write_file
      string = build_file_string
      File.open(@file_path, "a+") do |f|
        f.write(string)
      end
    end

    def self.build_and_write_file(commands)
      fo = self.new(commands)
      fo.write_file
      fo
    end

    def apply_crontab
      puts `whenever -w`
    end

    private

      def validate_and_clean_dsl_opts(opts)
        # TODO: Some form of validation
        opts
      end

      def dsl_erb_template(opts = {})
        opts = validate_and_clean_dsl_opts(opts)
        ERB.new(<<-METHOD
  every <%= opts[:period] %> do
    <%= opts[:runner_type] %> "<%= opts[:runner_command] %>"
  end
        METHOD
        ).result(binding)
      end

      def build_file_string
        @commands.map do |cmd|
          dsl_erb_template(cmd)
        end.join("\n")
      end

  end
