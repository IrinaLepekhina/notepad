# frozen_string_literal: true

require 'optparse'
require 'optparse/time'
require 'ostruct'

# Parse options
class Optparse
  attr_reader :parser, :options

  def parse(args)
    @options = ScriptOptions.new
    @args    = OptionParser.new do |parser|
      @options.define_options(parser)
      parser.parse!(args)
    end
    @options
  end
end
