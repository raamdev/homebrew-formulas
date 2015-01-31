require 'formula'

class WebsharksHubflow < Formula
  version "140811"
  homepage "http://github.com/websharks/hubflow"
  url "https://github.com/websharks/hubflow.git"
  sha1 "4bde2d619f00741b34714b3be74ae21af79d648c"

  def install
    ENV['INSTALL_INTO'] = libexec
    system "./install.sh", "install"
    bin.write_exec_script libexec/'git-hf'
  end

  test do
    system bin/"git-hf", "version"
  end
end
