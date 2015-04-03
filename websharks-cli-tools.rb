require "formula"

class WebsharksCliTools < Formula
  # Formula source and info.
  homepage "https://github.com/websharks/cli-tools"
  head "https://github.com/websharks/cli-tools.git", :branch => "000000-dev"
  url "https://github.com/websharks/cli-tools.git", :tag => "000000-dev"

  # Terminal notifier used by some OSA scripts.
  depends_on "terminal-notifier" => :recommended

  # Installation routine.
  def install # Install repo files.
    prefix.install Dir["*"] # Copy all files.
  end

  test do # Test routine.
    # Not tests at this time.
  end
end
