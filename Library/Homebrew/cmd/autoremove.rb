# frozen_string_literal: true

require "formula"
require "cli/parser"

module Homebrew
  module_function

  def autoremove_args
    Homebrew::CLI::Parser.new do
      usage_banner <<~EOS
        `autoremove`

         autoremove is used to remove packages that were automatically installed to satisfy
         dependencies for other packages and are now no longer needed as dependencies changed
         or the package(s) needing them were removed in the meantime.
      EOS

      max_named 0
    end
  end

  def autoremove
    args = autoremove_args.parse
    uninstall_cmd(
      named: leaves_list,
      verbose: args.verbose?
    )
  end
end
