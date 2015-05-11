require "formula"
require File.expand_path("../../Requirements/Php/websharks-php-version-requirement", __FILE__)

class WebsharksCliTools < Formula
  homepage "https://github.com/websharks/cli-tools"
  head "https://github.com/websharks/cli-tools.git", :branch => "000000-dev"
  url "https://github.com/websharks/cli-tools.git", :tag => "000000-dev"

  depends_on WebsharksPhpVersionRequirement
  depends_on "terminal-notifier" => :recommended

  def install
    prefix.install Dir["*"]
  end

  test do
  end
end
