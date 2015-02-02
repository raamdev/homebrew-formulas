require 'formula'

class WebsharksHubflow < Formula
  homepage "https://github.com/websharks/hubflow"
  head "https://github.com/websharks/hubflow.git"
  url "https://github.com/websharks/hubflow/archive/master.tar.gz"

  def install
    ENV['INSTALL_INTO'] = libexec
    system "./install.sh", "install"
    bin.write_exec_script libexec/'git-hf'
  end

  test do
    system bin/"git-hf", "version"
  end
end
