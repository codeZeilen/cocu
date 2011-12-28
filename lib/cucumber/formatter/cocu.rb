require 'rubygems'
require 'cucumber/formatter/io'
require 'cucumber/formatter/console'

module Cucumber
  module Formatter
    class CoCu
      include Io
      include Console

      attr_accessor :step_mother

      def initialize(step_mother, path_or_io, options)
        @io = ensure_io(path_or_io, "cocu")
        @step_mother = step_mother
        @options = options

        @current_feature_name = ""
        @scenarios = []
        @feature_element_passed = true
      end

      def after_features(features)
        print_summary(features)
      end

      def before_feature(feature)
        @scenarios = []
      end

      def after_feature(feature)
        path_string = Pathname.new(feature.file).basename.to_s + ": "  #@current_feature_name, :passed)
        feature_name = format_string(reformat_name(feature.name), :comment)
        @io.puts path_string + feature_name
        @scenarios.each do |scenario_string|
          @io.puts scenario_string
        end
        @io.puts "\n"
      end

      def feature_name(keyword, name)
        @current_feature_name = "#{keyword}: #{name}"
      end

      def before_feature_element(feature_element)
        @feature_element_passed = true
        @current_exception = ""
      end

      def before_step_result(keyword, step_match, multiline_args, status, exception, source_indent, background)
        @feature_element_passed = (@feature_element_passed && (status == :passed))

        #step = step_match.step_definition
        if status == :failed 
          @failed_step = format_step(keyword, step_match, status, source_indent)
          @step_exception = format_string("Error: #{exception}", status)
        end
      end

      def after_feature_element(feature_element)
        scenario_string = " " * 4

        result = @feature_element_passed ? :passed : :failed
        scenario_string << format_string(feature_element.title, result)

        if !@feature_element_passed
          scenario_string << "\n" + (" " * 6) 
          scenario_string << @failed_step
          scenario_string << "\n" + (" " * 6) 
          scenario_string << @step_exception
        end

        @scenarios << scenario_string
      end

      def reformat_name(name_string)
        text = name_string.split().join(" ") 
        first_line = text[0,24].nil? ? "" : text[0,24].strip
        second_line = text[24,52].nil? ? "" : text[24,52].strip
        third_line = text[76,48].nil? ? "" : text[76,48].strip
        result = [first_line, second_line, third_line].join("\n").strip
        r = text[127].nil? ? result : result + "..."
        return r
      end

      private

      def print_summary(features)
        print_stats(features, @options)
      end
    end
  end
end
