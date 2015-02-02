require 'formula'

class WebsharksHubflow < Formula
  homepage "https://github.com/websharks/hubflow"
  head "https://github.com/websharks/hubflow.git", :branch => "000000-dev"
  url "https://github.com/websharks/hubflow.git", :branch => "master"

  def install
    ENV['INSTALL_INTO'] = libexec
    system "./install.sh", "install"
    bin.write_exec_script libexec/'git-hf'
  end

  test do
    system bin/"git-hf", "version"
  end
end
