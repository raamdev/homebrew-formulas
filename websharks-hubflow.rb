require "formula"

class WebsharksHubflow < Formula
  version "latest" # Latest version.
  homepage "https://github.com/websharks/hubflow"
  head "https://github.com/websharks/hubflow.git", :branch => "000000-dev"
  url "https://github.com/websharks/hubflow.git", :branch => "master"

  option "with-x", "Unused at this time."

  def install
    ENV['INSTALL_INTO'] = libexec
    system "./install.sh", "install"
    bin.write_exec_script libexec/'git-hf'
  end

  test do
    system bin/"git-hf", "version"
  end
end
