# typed: false
# frozen_string_literal: true

require "formula"
require "tab"
require "cli/parser"

module Homebrew
  module_function

  def leaves_args
    Homebrew::CLI::Parser.new do
      usage_banner <<~EOS
        `leaves`

        List installed formulae that are not dependencies of another installed formula.
      EOS

      max_named 0
    end
  end

  def leaves_list
    leaves_args.parse

    installed = Formula.installed.sort
    deps_of_installed = installed.flat_map(&:runtime_formula_dependencies)
    installed.map(&:full_name) - deps_of_installed.map(&:full_name)
  end

  def leaves
    leaves_list.each(&method(:puts))
  end
end
