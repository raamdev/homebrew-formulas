require 'formula'

class WebsharksOsa < Formula
  version "150131"
  homepage "https://github.com/websharks/osa"
  url "https://github.com/websharks/osa.git"
  sha1 "5449db480c6154d69e8614f66fe06525fbd2b7b4"

  def install
    prefix.install Dir["*"]
    script_libraries = File.expand_path("~/Library/Script Libraries")

    if !File.directory? "#{script_libraries}"
      mkdir "#{script_libraries}"
    end
    ln_s "#{prefix}", "#{script_libraries}/websharks", :force => true
  end

  test do
  end
end