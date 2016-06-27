require "formula"

class WebsharksHubflow < Formula
  homepage "https://github.com/websharks/hubflow"
  head "https://github.com/websharks/hubflow.git", :branch => "dev"
  url "https://github.com/websharks/hubflow.git", :tag => "160627"

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
